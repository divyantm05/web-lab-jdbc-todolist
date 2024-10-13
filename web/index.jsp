<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pojo.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ToDo List</title>
    <style>
        * {
            font-family: 'Roboto', Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            min-height: 100vh;
        }

        .input-container {
            width: 400px;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            margin-bottom: 20px;
        }

        input[type="text"] {
            width: 80%;
            height: 40px;
            padding: 0 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        input[type="submit"] {
            height: 40px;
            padding: 0 20px;
            background-color: #6200ee;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .task-container {
            width: 400px;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 20px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

        li:last-child {
            border-bottom: none;
        }

        button {
            background-color: #e53935;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        button:hover {
            background-color: #d32f2f;
        }
    
    </style>
</head>
<body>
    <div class="input-container">
        <form action="todoServlet" method="post">
            <input type="text" name="task" id="task" placeholder="add a new task" required>
            <input type="submit" name="action" value="add">
        </form>
    </div>    
    <div class="task-container">
        <ul>
        <% 
            List<Task> tasks = (List<Task>) request.getAttribute("tasks"); 
            if (tasks != null) {
                for (Task task : tasks) { 
        %>
            <li>
                <%= task.getTask() %> 
                <form action="todoServlet" method="post" style="display:inline;">
                    <input type="hidden" name="taskId" value="<%= task.getId() %>"> 
                    <input type="hidden" name="action" value="remove"> 
                    <button type="submit">Remove</button>
                </form>
            </li>
        <% 
                }
            }
        %>
    </ul>
    </div>
</body>
</html>
