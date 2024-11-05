<?php
require 'conexao.php';

$message = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['edit'])) {
        
        $fornecedor_numero = $_POST['fornecedor_numero'];
        $endereco = $_POST['endereco'];

        $stmt = $conn->prepare("UPDATE Fornecedor SET endereco=? WHERE fornecedor_numero=?");
        if ($stmt) {
            $stmt->execute([$endereco, $fornecedor_numero]);
            $message = "Fornecedor atualizado com sucesso.";
        } else {
            $message = "Erro ao atualizar fornecedor: " . $stmt->errorInfo()[2];
        }
    } elseif (isset($_POST['delete'])) {
        $fornecedor_numero = $_POST['fornecedor_numero'];

        $stmt = $conn->prepare("DELETE FROM Fornecedor WHERE fornecedor_numero=?");
        if ($stmt) {
            $stmt->execute([$fornecedor_numero]);
            $message = "Fornecedor excluído com sucesso.";
        } else {
            $message = "Erro ao excluir fornecedor: " . $stmt->errorInfo()[2];
        }
    } else {
        $fornecedor_numero = $_POST['fornecedor_numero'];
        $endereco = $_POST['endereco'];

        $stmt = $conn->prepare("INSERT INTO Fornecedor (fornecedor_numero, endereco) VALUES (?, ?)");
        if ($stmt) {
            $stmt->execute([$fornecedor_numero, $endereco]);
            $message = "Fornecedor cadastrado com sucesso.";
        } else {
            $message = "Erro ao cadastrar fornecedor: " . $stmt->errorInfo()[2];
        }
    }
}

$sql = "SELECT * FROM Fornecedor";
$stmt = $conn->query($sql);
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Fornecedores</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
            color: #333;
        }

        h1, h2 {
            color: #4CAF50;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        input {
            margin-right: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: calc(50% - 22px);
        }

        button {
            padding: 10px 15px;
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        #treeview {
            list-style-type: none;
            padding: 0;
        }

        #treeview li {
            margin: 10px 0;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .edit, .delete {
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            background-color: #007BFF;
            color: white;
            transition: background-color 0.3s;
        }

        .edit:hover {
            background-color: #0056b3;
        }

        .delete {
            background-color: #dc3545;
        }

        .delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <h1>Cadastro de Fornecedores</h1>
    <?php if ($message) echo "<p>$message</p>"; ?>
    <form method="POST" action="fornecedor.php">
        <input type="number" name="fornecedor_numero" placeholder="Número do Fornecedor" required>
        <input type="text" name="endereco" placeholder="Endereço" required>
        <button type="submit">Cadastrar Fornecedor</button>
    </form>

    <h2>Fornecedores Cadastrados</h2>
    <ul id="treeview">
        <?php
        if (count($result) > 0) {
            foreach ($result as $row) {
                echo "<li data-fornecedor_numero='" . htmlspecialchars($row['fornecedor_numero']) . "' data-endereco='" . htmlspecialchars($row['endereco']) . "'>";
                echo htmlspecialchars($row['fornecedor_numero']) . " - " . htmlspecialchars($row['endereco']);
                echo " <button class='edit'>Editar</button>";
                echo " <button class='delete'>Excluir</button>";
                echo "</li>";
            }
        } else {
            echo "<li>Nenhum fornecedor cadastrado.</li>";
        }
        ?>
    </ul>

    <script>
        document.querySelectorAll('.edit').forEach(button => {
            button.addEventListener('click', function() {
                const li = this.parentElement;
                const numero = li.getAttribute('data-fornecedor_numero');
                const endereco = li.getAttribute('data-endereco');
                document.querySelector('input[name="fornecedor_numero"]').value = numero;
                document.querySelector('input[name="endereco"]').value = endereco;
            });
        });

        document.querySelectorAll('.delete').forEach(button => {
            button.addEventListener('click', function() {
                const li = this.parentElement;
                const numero = li.getAttribute('data-fornecedor_numero');
                if (confirm('Tem certeza que deseja excluir este fornecedor?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = 'fornecedor.php';
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'fornecedor_numero';
                    input.value = numero;
                    const deleteInput = document.createElement('input');
                    deleteInput.type = 'hidden';
                    deleteInput.name = 'delete';
                    form.appendChild(input);
                    form.appendChild(deleteInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        });
    </script>
</body>
</html>