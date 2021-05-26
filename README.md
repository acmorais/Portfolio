# Portfolio_caseZax

<img src="https://github.com/acmorais/AnaMorais/blob/main/Ana%20Morais_lkd.png">

[<img src="https://img.shields.io/badge/linkedin-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" />](https://www.linkedin.com/in/anacmorais/) [<img src="https://img.shields.io/badge/Visite_meu_Site-%23E4405F.svg?&style=for-the-badge&logo=site&logoColor=white" />](https://www.acmorais.com.br/) 

## Análise de dados do histórico de transações de clientes de um e-commerce de varejo

### **1.	Introdução**

 A Zax é uma empresa que facilita a compra e venda entre o atacadista do Brás e da 25 de março e o lojista de todo o Brasil, por meio do aplicativo Zax.
A Zax quer oferecer crédito para que seus clientes possam ter mais folego nas suas vendas e, para definir o melhor caminho, deve ser analisado um dataset com o histórico de transações dos clientes, o qual possui as seguintes informações:

* Código do cliente
* Código do pedido
* Cidade para onde o pedido foi enviado
* Estado para onde o pedido foi enviado
* Data de criação do pedido
* O # de lojas diferentes no pedido
* Preço médio dos itens do pedido
* Quantidade de itens no pedido
* Método de pagamento
*	Método de envio
  
Os problemas de negócio que devem ser respondidos a partir da análise deste dataset são:
1)	Para quais clientes a Zax deve ofertar o crédito e por quê?
2)	Qual seria o valor ideal para cada?
3)	Quanto dinheiro a Zax estaria arriscando?

O arquivo que contém as informações é do tipo .csv e possui 17MB. Por ser um dataset pequeno, seria possível analisá-lo diretamente pelo Power BI. No entanto, farei algumas consultas no SQL Server para ter uma ideia geral das informações contidas e fazer algumas modificações no que for necessário.
  <br/>
  <br/>

### **2.	Desenvolvimento**
<br/>
Na primeira observação que fiz do *dataset*, foi possível verificar que o mesmo pedido estava sendo registrado 3 vezes, pois as informações sobre: # de lojas diferentes no pedido, preço médio dos itens do pedido e quantidade de itens no pedido estavam cada uma em uma linha dos três registros. A descrição estava no campo "Nomes_de_medida" e o valor estava no campo "Valores_de_medida". Assim, o *dataset* possuia 9 colunas e 147054 linhas.
  <br/>
  
Seria preciso transformar cada uma dessas observações em atributos, ou seja, criar três colunas com os nomes: [# de lojas diferentes no pedido], [Preço médio dos itens] e [Quantidade de itens], cada uma com seus respectivos valores e, assim, manter um pedido por linha do *dataset* (um pedido = um registro).  
   <br/>
   <br/>
   
   ![description="Query no SQL Server com os registros triplicados" ](https://github.com/acmorais/Portfolio_casezax/blob/main/query_registros.JPG)
    <br/>
    <br/>
    
   Ainda no SQL Server, realizei algumas querys para conferir se haviam campos nulos ou vazios, qual o período compreendido no dataset e confirmar se só haviam mesmo os registros # de lojas diferentes no pedido, Preço médio dos itens e Quantidade de itens na coluna "Nomes_de_medida" para, então, transformar essas linhas em atributos. 
   O script com todas as querys pode ser acessado aqui: <https://github.com/acmorais/Portfolio_casezax/blob/main/case_zax.sql>
   
   Assim, no SQL Server foi criada uma view de nome *new_dados* já com as informações de quantidade de lojas diferentes no pedido, preço médio dos itens e quantidade de itens como atributos (colunas) da planilha, sendo cada pedido de compra apenas um registro (uma linha) do *dataset*. Essa view ficou com 10 colunas e 49018 linhas e foi importada para o Power BI para continuar a análise.
   
   ![view_para_levar_ao_PBI](https://github.com/acmorais/Portfolio_casezax/blob/main/query_new_Dados.JPG)
   
   No Power BI foi possível alterar os tipos de dados das colunas, criar uma coluna nova calculada com o Valor total de cada pedido ([Qtde de itens * Preço médio do pedido]) e criar diversas visualizações para responder aos problemas de negócio.
   
   Quando se trata de clientes, é fundamental trabalharmos com algumas informações importantes como Ticket Médio e Lifetime Value (LTV), pois podemos realizar comparações a partir do entendimento sobre o padrão dos seus clientes. O Power BI permite criar medidas a partir de funções DAX e, então, criei 4 indicadores: Ticket Médio, LTV anual, média de compra anual por cliente e projeção de faturamento anual. Optei por extrapolar os resultados desses 7 meses compreendidos no *dataset* (de 01/11/2020 a 21/05/2021) para 12 meses e, assim, saber qual LTV no período de um ano e, também, o padrão de compra anual.
    <br/>
    
   As novas medidas foram realizadas da seguinte maneira:
   - Ticket Médio: calculado dividindo o Valor Total pelo número de pedidos. 
   - A média de compra nesses 7 meses: divisão do número de pedidos pelo número de clientes (24.800 clientes).
   - A média de compra anual: divisão de 12 meses por 7 e multiplicado pela média de compra dos 7 meses, calculada anteriormente.
   - LTV (*lifetime value*): Ticket médio multiplicado pela média de compra anual. Ou seja, quanto cada cliente gasta em média no período de um ano.
   - Projeção do faturamento bruto a partir desses dados: LTV multiplicado pelo total de clientes. 
   <br/>
   
   Chegamos em alguns valores importantes para começarmos a avalair para quais clientes a ZAX irá ofertar crédito.
   * **Ticket Médio:** R$288,99
   * **LTV:** R$979,15
   * **Média de compra por ano:** 3 compras por cliente
   * **Projeção faturamento bruto:** R$24,3 Milhões 
   <br/>
   
   A partir dessas métricas, verifiquei que a ZAX possui 4 perfis de clientes: o primeiro, que corresponde a grande maioria (63,8% do total), tem tanto LTV quanto ticket médio abaixo da média, ou seja, esses clientes compram poucas vezes no ano e gastam pouco individualmente. Porém, esses clientes correspondem a um valor alto em relação ao faturamento total.
<br/>

   O segundo perfil é dos clientes que possuem ticket médio baixo, ou seja, suas compras tem valor baixo, porém, possuem alto LTV, o que significa que compram muitas vezes ao longo do ano, esses são os clientes mais assíduos da ZAX, precisamos olhar para eles com carinho e tentar propor ações que aumentem seu ticket médio. Esses clientes correspondem a 7,4% do total de clientes.
 <br/>
 
O terceiro perfil corresponde a 10,8% do total de clientes e traz aqueles que possuem ticket médio alto, porém, baixo LTV. Esses clientes têm um grande potencial de compra e devem ser estimulados a comprarem mais vezes, pois significa que quando compram, gastam mais do que a média. 
 <br/>
 
   Por fim, o quarto perfil observado é daqueles que tem Ticket Médio e LTV altos. Ou seja, são os clientes que realizam compras grandes e com frequência, e que naturalmente, se estimulados a comprarem sempre mais, contribuirão com um percentual importante no faturamento, mesmo correspondendo a apenas 18% do total de clientes.
    <br/>
    As informações desses perfis podem ser visualizadas abaixo:
<br/>   

   ![description="Clientes com baixos Ticket e LTV" ](https://github.com/acmorais/Portfolio_casezax/blob/main/tmbx_ltvbaixo.JPG)               ![description="Clientes com baixo Ticket e alto LTV" ](https://github.com/acmorais/Portfolio_casezax/blob/main/tmbx_ltvalto.JPG)
<br/> 
<br/> 
É importante ressaltar que os clientes com baixos ticket e LTV, por serem a grande maioria dos clientes, foram responsáveis por 20% de todo o faturamento. 

Os clientes cujo ticket médio é baixo, porém com alto LTV, correspondem a 14,3% do total de faturamento nesses 7 meses.
<br/> 
<br/>
 ![description="Clientes com alto Ticket e baixo LTV" ](https://github.com/acmorais/Portfolio_casezax/blob/main/tmalto_bxltv.JPG)    ![description="Clientes com altos Ticket e LTV" ](https://github.com/acmorais/Portfolio_casezax/blob/main/tmalto_ltvalto.JPG)
  <br/>    
  <br/>
  Os clientes classificados como 3º perfil correspondem a 7,2% do faturamento e, por fim, as compras dos clientes com alto LTV e alto ticket correspondem a 55,5% de todo faturamento. Ou seja, são imprescindíveis para a saúde do negócio.
  <br/>    
  <br/> 

## 2.1 Respostas aos problemas de negócio
  <br/>    
  <br/>
  
   **1)	Para quais clientes a Zax deve ofertar o crédito e por quê?**
   <br/>   
      A partir desses parâmetros, sugiro que, neste primeiro momento, a ZAX olhe para 3 desses 4 perfis de cliente para os quais ofertará crédito.
   <br/> 
   
   Para o 4º perfil descrito, dos que têm altos ticket médio e LTV, pois suas compras resultam em mais da metade de todo o faturamento anual da ZAX. Esses clientes precisam ser premiados e incentivados a continuar gastando. 
  <br/>     
 
  Para o 3º perfil descrito, dos que têm alto ticket médio e baixo LTV, precisamos aumentar a frequência com que eles compram. Conforme havia dito, são clientes com alto poder de compra, por isso, precisamos incentivá-los a comprar mais e, assim, trazerem um retorno ainda maior.
  
  <br/>
  
  E, por fim, a ZAX deve ofertar desconto para o perfil de clientes assíduos, ou seja, aqueles que estão sempre comprando. Apesar de terem um ticket médio baixo, esses são os clientes que estão sempre no aplicativo e estão sempre ligados nas novidades, promoções e, com isso, têm um alto potencial para trazerem novos clientes pelo marketing *word of mouth*.
   <br/>
   <br/>
   
   **2)	Qual seria o valor ideal para cada?**
   <br/>
   
   Para o 4º perfil descrito, seria ofertado um voucher com 10% de desconto para a próxima compra acima de R$500 que fizerem. Como o ticket médio desse perfil é de R$639,29 e eles têm alto LTV, sabemos que comprarão em breve e, provavelmente, com um valor acima do mínimo do voucher, então, não vejo a necessidade de colocar um vencimento curto para o uso desse voucher. Caso precisemos definir um prazo para uso, creio que de 2 meses é um bom prazo, visto que esses clientes compram, em média, a cada 2,4 meses.
   <br/>
   
   Para o 3º perfil descrito, acho interessante que o prazo de vencimento do voucher seja menor, para incentivar que comprem mais vezes, e com valor acima de R$300 (acima do ticket médio), para não diminuir o ticket médio. O voucher pode conceder R$30,00 de desconto. 
  <br/>
  
  Com foco nesses dois perfis, poderia-se também verificar a criação de um clube de fidelidade, que premia com descontos no carrinho ou no frete a cada *x* valor total comprado.
 <br/>  
 Para o 2º perfil descrito, precisamos aumentar o ticket médio deles, então só faz sentido que o voucher de desconto possa ser usado para compras acima de R$300 (acima do ticket médio). Podendo ser concedido R$15,00 de desconto.
  <br/>
  <br/>
  
   **3)	Quanto dinheiro a ZAX estaria arriscando?**
   
     
   Os cálculos foram realizados, levando-se em conta o ticket médio de cada grupo.
   Para o 4º perfil de clientes, se todos utilizarem o voucher, o custo da ZAX será de R$285.698,71, sendo que as compras deles, pelo valor mínimo do voucher a ser utilizado (R$500,00), totalizaria R$ 2.234.500,00 em dois meses. Se eles mantiverem o ticket médio de compra, será de R$ 2.856.987,01.
    <br/>
    
   Para o 3º perfil de clientes, se todos utilizassem o voucher, o custo da ZAX será de R$ 80.670,00, sendo que as compras deles, pelo valor mínimo do voucher (R$300), totalizaria R$ R$806.700,00. Se eles mantiverem o ticket médio de compras deles (R$395,29), o que é mais provável, o valor total das compras poderá chegar a R$1.062.934,81.
   <br/>
   
   Para o 2º perfil de clientes, aos quais concederemos R$15,00 de desconto, o custo para a ZAX, se todos usarem o voucher será de R$27.435,00. E um retorno de R$548.700,00.
  <br/>
     
   Assim, o custo total para a ZAX é de **R$ 393.803,71**, podendo chegar a um **faturamento de R$4.468.621,82**, se todos os clientes do grupo comprarem e mantiverem seus tickets médios.
   
  
##  **3. Conclusão**
<br/>
   
   É claro que uma análise de *consumer behavior* traria diversas outras respostas mais profundas sobre em que contexto os clientes da ZAX compram e quais as motivações e percepções que influenciam a decisão de compra deles. 
<br/>

   Um estudo mais aprofundado pode ser considerado no futuro, devendo trazer um histórico maior de compras e podendo construir modelo de machine learning para aperfeiçoar o entendimento sobre o cliente, separando-os em perfis cada vez mais específicos e, assim, entregar experiências mais individualizadas e satisfazer suas necessidades.  
   
   
   
   
   
   
