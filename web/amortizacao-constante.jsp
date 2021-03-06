<%@include file="WEB-INF/jspf/header.jspf"%>
<%@include file="WEB-INF/jspf/menu.jspf"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <title>Amortização Constante</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    
    <body style="background-color:gainsboro;">
        <center>
            <h2 style='color: black'>Sistema De Amortização Constante</h2>
        <%
            //Inicializando as variáveis
        double emprestimo = 10;
        int nprestacao = 10;
        double juros = 10;
        double amortizacao = 10;
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
        amortizacao = emprestimo/nprestacao; //Calculo de amortização fixa
        double sd[] = new double[nprestacao]; //Vetor p/ guardar saldo devedor 
        sd[0] = emprestimo; //Inicializando no indice 0 com o Valor do emprestimo Inicial
        double jurosS[] = new double[nprestacao]; //Vetor para guardar juros q vai ser modificado
        jurosS[0] = sd[0] * (juros/100); //Inicializando no indice 0 com o Juros Inicial
        double prestacao[] = new double[nprestacao];// Vetor para guardar as 
        double totaljuros = jurosS[0]; 
        double totalprestacao = 0;
        for(int i = 1; i <nprestacao; i++){
            sd[i] = sd[(i-1)] - amortizacao; // Calculo saldo devedor
            jurosS[(i)] = sd[i] * (juros/100); //Calculo do juros
            totaljuros = totaljuros +  jurosS[(i)];
        }        
        
        for(int j = 0; j <nprestacao; j++){//Calculando as prestações
         prestacao[j] =  jurosS[j] + amortizacao;
         totalprestacao = totalprestacao + prestacao[j];
        }
       
        %>
         <%if(request.getParameter("juros") == "" || request.getParameter("emprestimo") == ""|| 
                        request.getParameter("nprestacao") == ""){%>
                        <h3 style="color:red">Erro, Insira todos os dados no formulário!</h3>
         <%}%>
        <% if(request.getParameter("btnenviar") != null){ %> <!-- Verificação de form vazio-->
                <hr/>
                <table border = "1">
                   
                    <tr><th>Meses</th><th>Saldo Devedor</th><th>Amortização</th><th>Juros</th><th>Prestação</th></tr>
                    <!-- Mês 0, onde ele tira o emprestimo -->
                    <tr><td>0</td>
                    <td>R$ <%=(df.format(sd[0]))%></td>
                    <td>&emsp; &emsp;-</td>
                    <td>&emsp; -</td>
                    <td>&emsp;&ensp; -</td>
                    </tr>
                   <!-- Mês 1 ao final, onde começa a pagar e amortizar -->
                   <%for(int i = 0; i <nprestacao ; i++){ %>
                   <tr>
                        <td><%=(i+1)%></td>
                        <%if((i+1) == nprestacao){%>
                        <td>&emsp;R$ 0,00</td>
                        <%} else{ %>
                        <td>R$ <%=(df.format(sd[i+1]))%></td>
                        <%}%>
                        <td>R$ <%=(df.format(amortizacao))%></td>
                        <td>R$ <%=(df.format(jurosS[i]))%></td>
                        <td>R$ <%=(df.format(prestacao[i]))%></td>
                   </tr>
                    <%}%>
                    <!--Parte do TOTAL da tabela -->
                    <tr>
                      <th><b>TOTAL:</b></th>
                      <td> &emsp; &emsp; - </td>
                      <td style="color:green">R$ <%=(df.format(amortizacao * nprestacao))%></td>
                       <td style="color:green">R$ <%=(df.format(totaljuros))%></td>
                       <td style="color:green">R$ <%=(df.format(totalprestacao))%></td>
                    </tr>
                </table>                     
                <%}%>
                
               
               
               <%@include file="WEB-INF/jspf/footer.jspf"%>
        </center>
    </body>
</html>
