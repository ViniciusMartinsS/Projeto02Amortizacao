<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tabela Price</title>
    </head>
    <body>
        <!--Titulo do sistema-->
        <h2 style='color: blue'>Sistema Francês De Amortização (Tabela Price)</h2>
         <%@include file="WEB-INF/jspf/header.jspf"%>
        <%
            //Inicializando as variáveis
        double emprestimo = 10;
        int nprestacao = 10;
        double juros = 10;
        
        //try and catch para pegar os valores inseridos pelo user via form
        try{
            emprestimo = Double.parseDouble(request.getParameter("emprestimo"));
            nprestacao = Integer.parseInt(request.getParameter("nprestacao"));
            juros = Double.parseDouble(request.getParameter("juros"));
        }catch(Exception ex){
           
        }
        %>
        <!--Recebendo valores pelo form -->
        <form>
            Valor do empréstimo:<br/> 
            <input type="number" value="" name="emprestimo" min ="1" step="0.01" placeholder="R$"/><br/>
            Quantidade de parcelas:<br/>
            <input type="number" value="" name="nprestacao" min ="1" placeholder="Parcelas"/><br/>
            Taxa de juros ao mês:<br/>
            <input type="number" value="" name="juros" min ="1" step="0.01" placeholder="%"/><br/>
            <input type="submit" value="Enviar" name="btnenviar"/> &emsp; &emsp;
            <input type="reset" value="Limpar" name="btnlimpar"/>
        </form>
        <!--Processando dados-->
        <%
        DecimalFormat df = new DecimalFormat("###,###.00");//Valor ficar igual ao real
        double prestacao = 0;
        juros = (juros/100);
        double conta = (1 + juros);
        prestacao = emprestimo * ((Math.pow(conta,nprestacao) * juros)/(Math.pow(conta,nprestacao) - 1));
        double sd[] = new double[nprestacao];
        double jurosS[] = new double[nprestacao];
        double amortizacao[] = new double[nprestacao];
        sd[0] = emprestimo;
        jurosS[0]= sd[0] * juros;
        amortizacao[0] = prestacao - jurosS[0];
        double totaljuros = jurosS[0]; 
        double totalamortizacao = amortizacao[0];
        for(int i = 1; i <nprestacao; i++){
            sd[i] = sd[(i-1)] - amortizacao[(i-1)];
            jurosS[i] = sd[i] * juros;
            amortizacao[i] = prestacao - jurosS[i];
            totaljuros = totaljuros +  jurosS[i];
            totalamortizacao = totalamortizacao + amortizacao[i];
                    }

        %>
       
         <% if(request.getParameter("btnenviar") != null){ %>
         <hr/>
                <table border = "1">
                   
                    <tr><th>Meses</th><th>Saldo Devedor</th><th>Amortização</th><th>Juros</th><th>Prestação</th></tr>
                    <!-- Mês 0, onde ele tira o emprestimo -->
                    <tr>
                    <td>0</td>
                    <td>R$ <%=(df.format(sd[0]))%></td>
                    <td>&emsp; &emsp;-</td>
                    <td>&emsp; -</td>
                    <td>&emsp;&ensp; -</td>
                    </tr>
                                    
                   <!-- Mês 1 ao final, onde começa a pagar e amortizar -->
                   <%for(int i = 0; i <nprestacao; i++){ %>
                   <tr>
                        <td><%=(i+1)%></td>
                        <%if((i+1) == nprestacao){%>
                        <td>&emsp;R$ 0,00</td>
                        <%} else{ %>
                        <td>R$ <%=(df.format(sd[i+1]))%></td>
                        <%}%>
                        <td>R$ <%=(df.format(amortizacao[i]))%></td>
                        <td>R$ <%=(df.format(jurosS[i]))%></td>
                        <td>R$ <%=(df.format(prestacao))%></td>
                   </tr>
                    <%}%>
                    
                    <!--Parte do TOTAL da tabela -->
                    <tr>
                      <th><b>TOTAL:</b></th>
                      <td> &emsp; &emsp; - </td>
                      <td style="color:green">R$ <%=(df.format(totalamortizacao))%></td>
                       <td style="color:green">R$ <%=(df.format(totaljuros))%></td>
                       <td style="color:green">R$ <%=(df.format(prestacao * nprestacao))%></td>
                    </tr>
                </table>
<%}%>
                <%if(request.getParameter("juros") == "" || request.getParameter("emprestimo") == ""|| 
                        request.getParameter("nprestacao") == ""){%>
                        <h3 style="color:red">Erro, Insira todos os dados no formulário!</h3>
                <%}%>
    </body>
</html>
