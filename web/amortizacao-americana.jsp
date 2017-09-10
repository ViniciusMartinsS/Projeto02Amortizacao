<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização Americana</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf"%>
        <h2>Sistema De Amortização Americana</h2>
         <%
            //declaração e tratamentos da variavies
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
        <form name="frmvalores">
            Valor do emprestimo:<br><input type="text" name="emprest" value="" placeholder="R$"/>
            <br>
            Quantidade de parcelas:<br><input type="text" name="quantparcelas" value="" placeholder="5"/>
            <br>
            Taxa de juros ao mês:<br><input type="text" name="taxames" value="" placeholder="2,5%"/><br>
            <input type="submit" name="idform" value="Calcular"/>
            <input type="reset" name="btn-calcelar" value="Calcelar"/>
        </form>
        <hr>
        <%
            //Calculo para a tabela 
            DecimalFormat df = new DecimalFormat("###,###.00");
            taxames = (taxames /100 );
            double saldodevedor[] = new double [quantparcelas];
            double juros[] = new double[quantparcelas];
            double prestacao[] = new double [quantparcelas];
            double amortizacao[] = new double [quantparcelas];
            double totaljuros = juros[0];
            double totalprestacao = prestacao[0];
            saldodevedor[0] = emprest;//calculo da primeira linha da tabela
            juros[0] = saldodevedor[0] * taxames;
            prestacao[0] = juros[0];
            amortizacao[0] = emprest;
            for (int i =1; i<quantparcelas; i++){
                juros[i] = juros[i]+ juros[i];
                prestacao[i] = juros[i];
                totaljuros = totaljuros + juros[i];
                totalprestacao = totalprestacao + prestacao[i];
            }
        %>
        <table border="1">
            <tr><th>Meses</th><th>Saldo Devedor</th><th>Amortização</th><th>Juros</th><th>Prestação</th></tr>
            <tr>
                    <td>0</td>
                    <td>R$ <%=(df.format(saldodevedor[0]))%></td>
                    <td>-</td>
                    <td>-</td>
                    <td>-</td>
                    </tr>
                    
                    <%for(int i = 0; i <quantparcelas; i++){ %>
                   <tr>
                        <td><%=(i+1)%></td>
                        <%if((i+1) == quantparcelas){%>
                        <td>&emsp;R$ 0,00</td>
                        <%} else{ %>
                        <td>R$ <%=(df.format(saldodevedor[i+1]))%></td>
                        <%}%>
                        <td>R$ <%=(df.format(amortizacao[i]))%></td>
                        <td>R$ <%=(df.format(juros[i]))%></td>
                        <td>R$ <%=(df.format(prestacao))%></td>
                    </tr>
                    <%}%>
                    <tr>
                        <th><strong>Total:</strong></th>
                        <td>-</td>
                        <td style="color:green">R$ <%=(df.format("amortizacao"))%></td>
                        <td style="color:green">R$ <%=(df.format("totaljuros"))%></td>
                        <td style="color:green">R$ <%=(df.format("totalprestacao"))%></td>
                    </tr>
        </table>
    </body>
</html>
