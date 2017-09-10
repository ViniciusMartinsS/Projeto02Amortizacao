<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aplicação Web - Calculo de amortização</title>
        <style>
            h1{
                color: white;
                width: 100%;
                height: 100px;
                background-color: #4682B4;
                font-family: verdana;
                font-size: 100%;
                border: 1px solid;
               
            }
            #equipe{
                font-family: verdana;
                
            }
            #rodapes{
                color: white;
                width: 100%;
                height: 50px;
                background-color: #4682B4;
                font-family: verdana;
                font-size: 150%;
                border: 1px solid;
                text-align: center;
                position: fixed;
                bottom: 0;
                left: 0;   
            }
        </style>
    </head>
    <body>
        <h1 style="position: static">Aplicação Web para calculo de amortização.|<%@include file="WEB-INF/jspf/header.jspf"%></h1>
        
        <!--h2>Instregrantes do grupo:</h2-->
        
        <h3>Sobre a aplicação:</h3>
        <p>Aplicação web voltada para calcular a amortização de 3 diferente 
            maneiras. São elas <strong>constante</strong>, <strong>americans
            </strong> é <strong>tabela price</strong>.</p>
        <div id="equipe">
        <h3>Sobre a dupla:</h3>
        <p>Saulo Pedro da Silva nickname no git:Ravansgit</p>
        <p>Vinicius Simone Martins nickname no git: </p>
        </div>
        <h4 id="rodapes">
            Projeto - Programção orientado a objeto.
        </h4>
    </body>
</html>
