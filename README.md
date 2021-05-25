# Portfolio_caseZax

<img src="https://github.com/acmorais/AnaMorais/blob/main/Ana%20Morais_lkd.png">

[<img src="https://img.shields.io/badge/linkedin-%230077B5.svg?&style=for-the-badge&logo=linkedin&logoColor=white" />](https://www.linkedin.com/in/anacmorais/) [<img src="https://img.shields.io/badge/Visite_meu_Site-%23E4405F.svg?&style=for-the-badge&logo=site&logoColor=white" />](https://www.acmorais.com.br/) 

## Análise de dados do histórico de transações de clientes de um e-commerce

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
Na primeira observação que fiz do *dataset*, foi possível verificar que o mesmo pedido fora registrado 3 vezes, pois as informações sobre: # de lojas diferentes no pedido, preço médio dos itens do pedido e quantidade de itens no pedido estavam cada uma em uma linha dos registros. A descrição estava no campo "Nomes_de_medida" e o valor de cada um estava no campo "Valores_de_medida". Seria preciso, então, transformar cada uma dessas observações em atributos, ou seja, criar três colunas com os nomes: [# de lojas diferentes no pedido], [Preço médio dos itens] e [Quantidade de itens], cada uma com seus respectivos valores e, assim, manter cada pedido com apenas um registro.  
   <br/>
   <br/>
   
   ![description="Query no SQL Server com os registros triplicados" ](https://github.com/acmorais/Portfolio_casezax/blob/main/query_registros.JPG)
   
   Ainda no SQL Server, realizei algumas querys para conferir se haviam campos nulos ou vazios, confirmar se só haviam os registros # de lojas diferentes no pedido, Preço médio dos itens e Quantidade de itens na coluna "Nomes_de_medida" para, então, transformar essas linhas em colunas. 
   O script com todas as querys feitas pode ser acessado aqui: <
   
