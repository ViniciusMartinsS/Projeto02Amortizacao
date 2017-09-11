<%@include file="WEB-INF/jspf/header.jspf"%>
<%@include file="WEB-INF/jspf/menu.jspf"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>  
        <title>Amortização Americana</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body style="background-color:gainsboro;">
        <center>
            <h2 style='color: black'>Sistema De Amortização Americana</h2>
         <%
            //declaração e tratamentos da variavies do usuario
            double amortA = 10;
            double emprest = 10;
            double taxames = 10;
            int quantparcelas = 10;
            try{
                emprest = Double.parseDouble(request.getParameter("emprest"));
            }catch(Exception ex){}
            try{
                quantparcelas = Integer.parseInt(request.getParameter("quantparcelas"));
            }catch(Exception ex){}
            try{
                taxames = Double.parseDouble(request.getParameter("taxames"));
            }catch(Exception ex){}

        %>
        <!--Formulario para entreada de dados do ussuario-->
        <form name="frmvalores">
            Valor do empréstimo:<br><input type="number" name="emprest" value="" placeholder="R$" min="1"/>
            <br>
            Quantidade de parcelas:<br><input type="number" name="quantparcelas" value="" placeholder="Parcelas" min="1"/>
            <br>
            Taxa de juros ao mês:<br><input type="number" name="taxames" value="" placeholder="%" min="1" step="0.01"/><br>
            <input type="submit" name="idform" value="Enviar"/>&emsp; &emsp;
            <input type="reset" name="btn-calcelar" value="Limpar"/>
        </form>
        
        <%
            //Calculo para a tabela 
            DecimalFormat df = new DecimalFormat("###,###.00");
            taxames = (taxames /100 );
            double saldodevedor[] = new double [quantparcelas];
            double juros[] = new double[quantparcelas];
            double prestacao[] = new double [quantparcelas];
            double amortizacao[] = new double [quantparcelas];
            saldodevedor[0] = emprest;
            juros[0] = saldodevedor[0] * taxames;
            double totaljuros = juros[0];
            prestacao[0] = juros[0];
            amortizacao[0] = emprest;
            double totalprestacao = amortizacao[0] + totaljuros;
            for (int i =1; i<quantparcelas; i++){
                juros[i] = juros[i]+ juros[i];
                prestacao[i] = juros[i];
                totaljuros = totaljuros + juros[0];
                totalprestacao = totalprestacao + prestacao[0];
            }
        %>
        <% if(request.getParameter("idform") != null){ %>
        <hr/>
        <table border="1">
            <tr><th>Meses</th><th>Saldo Devedor</th><th>Amortização</th><th>Juros</th><th>Prestação</th></tr>
            <tr>    
                    <!--Bloco responsavel pela primeira linha da tabela-->
                    <td>0</td>
                    <td>R$ <%=(df.format(saldodevedor[0]))%></td>
                    <td>&emsp; &emsp;-</td>
                    <td>&emsp; &emsp;-</td>
                    <td>&emsp; &emsp;-</td>
                    </tr>
                    <!--For que incere os valores na tabela-->
                    <%for(int i = 0; i <quantparcelas; i++){ %>
                   <tr>
                        <td><%=(i+1)%></td>
                        <%if((i+1) == quantparcelas){%>
                        <td>R$ 0,00</td>
                        <%} else{ %>
                        <td>R$ <%=(df.format(saldodevedor[0]))%></td>
                        <%}%>
                        <%if((i+1) == quantparcelas){%>
                        <td>R$ <%=(df.format(amortizacao[0]))%></td>
                        <%} else{ %>
                        <td>&emsp; &emsp;-</td>
                        <%}%>
                        <td>R$ <%=(df.format(juros[0]))%></td>
                        <%if((i+1) == quantparcelas){%>
                        <td>R$ <%=(df.format(amortizacao[0]+prestacao[0]))%></td>
                        <%} else{ %>
                        <td>R$ <%=(df.format(prestacao[0]))%></td>
                        <%}%>
                    </tr>
                    <%}%>
                    <tr>
                        <!--Bloco responsavel pela ultima linha da tabela-->
                        <th><strong>Total:</strong></th>
                        <td>&emsp; &emsp;-</td>
                        <td style="color:green">R$ <%=(df.format(amortizacao[0]))%></td>
                        <td style="color:green">R$ <%=(df.format(totaljuros))%></td>
                        <td style="color:green">R$ <%=(df.format(totalprestacao))%></td>
                    </tr>
        </table>
                     <%}%>    
                                     <%if(request.getParameter("taxames") == "" || request.getParameter("emprest") == ""|| 
                        request.getParameter("quantparcelas") == ""){%>
                        <h3 style="color:red">Erro, Insira todos os dados no formulário!</h3>
                <%}%>
                <%@include file="WEB-INF/jspf/footer.jspf"%>
        </center>
    </body>
</html>
