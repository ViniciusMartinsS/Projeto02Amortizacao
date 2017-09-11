<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Aplicação Web - Calculo de amortização</title>
        <style>
            #h1{
                color: white;
                width: 100%;
                height: 50px;
                background-color: #008B8B;
                font-family: verdana;
                font-size: 150%;
                position: inherit;
                border: 1px solid;
                text-align: center;
                
            }
            #equipe{
                font-family: verdana;
                
            }
            #rodapes{
                color: white;
                width: 100%;
                height: 50px;
                background-color: #008B8B;
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
    <body style="background-color:gainsboro;">
               <center><b style="color:black"> <%@include file="WEB-INF/jspf/header.jspf"%></b></center>
        <header id="h1">Aplicação Web para calculo de amortização</header>
       
        <!--h2>Instregrantes do grupo:</h2-->
        <div id="equipe">
        <h3>Sobre a aplicação:</h3>
        <p>Aplicação web voltada para calcular a amortização de 3 diferente 
            maneiras. São elas: <strong>Constante</strong>, <strong>Americana
            </strong> e <strong>Tabela Price</strong>.</p>
        </div>
        
        <div id="equipe">
        <h3>Sobre a dupla:</h3>
        <p>Saulo Pedro da Silva nickname no git:Ravansgit</p>
        <p>Vinicius Simone Martins nickname no git:ViniciusMartinsS </p>
        </div>
        
        <footer id="rodapes">
            Projeto - Programação orientado a objeto
        </footer>
    </body>
</html>
