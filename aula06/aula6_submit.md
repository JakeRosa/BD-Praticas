# BD: Guião 6

## Problema 6.1

### *a)* Todos os tuplos da tabela autores (authors);

```
select * from authors;
```

### *b)* O primeiro nome, o último nome e o telefone dos autores;

```
select au_fname, au_lname, phone from authors;
```

### *c)* Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente); 

```
select au_fname, au_lname, phone from authors
order by au_fname, au_lname asc;
```

### *d)* Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone); 

```
select au_fname as first_name, au_lname as last_name, phone as telephone from authors
order by first_name, last_name asc;
```

### *e)* Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’; 

```
select au_fname as first_name, au_lname as last_name, phone as telephone from authors
where authors.state='CA' and au_fname != 'Rigger'
order by first_name, last_name asc;
```

### *f)* Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome; 

```
select * from publishers
where pub_name like '%Bo%';
```

### *g)* Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’; 

```
select distinct pub_name from publishers, titles
where type='business'
```

### *h)* Número total de vendas de cada editora; 

```
select pub_name, sum(qty) as total_sales
from ((publishers join titles on publishers.pub_id=titles.pub_id) join sales on titles.title_id=sales.title_id)
group by pub_name;
```

### *i)* Número total de vendas de cada editora agrupado por título; 

```
select pub_name, sum(qty) as sales, titles.title
from ((publishers join titles on publishers.pub_id=titles.pub_id) join sales on titles.title_id=sales.title_id)
group by titles.title, pub_name;
```

### *j)* Nome dos títulos vendidos pela loja ‘Bookbeat’; 

```
select title 
from ((stores join sales on stores.stor_id=sales.stor_id) join titles on titles.title_id=sales.title_id)
where stor_name like 'Bookbeat';
```

### *k)* Nome de autores que tenham publicações de tipos diferentes; 

```
select authors.au_fname, authors.au_lname
from (authors join titleauthor on authors.au_id=titleauthor.au_id) join titles on titleauthor.title_id=titles.title_id 
group by authors.au_fname, authors.au_lname
having count(distinct[type])>1;
```

### *l)* Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
select pub_id, titles.type, avg(titles.price) as preco_medio, sum(titles.ytd_sales) as total_sales
from (titles join sales on titles.title_id = sales.title_id)
group by titles.pub_id, titles.type
```

### *m)* Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
select titles.type, max(advance) as max_advance, avg(advance) as avg_advance 
from titles
group by titles.type
having max(advance) > 1.5*avg(advance);
```

### *n)* Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
select titles.title, authors.au_fname, authors.au_lname, sum(qty*price) as total_profit
from (((titles join sales on titles.title_id=sales.title_id) join titleauthor on titles.title_id=titleauthor.title_id) join authors on authors.au_id=titleauthor.au_id)
group by titles.title, authors.au_fname, authors.au_lname;
```

### *o)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
select title, ytd_sales,price*ytd_sales as vendas, price*ytd_sales*royalty/100 as author_profit, price*ytd_sales-price*ytd_sales*royalty/100 as publisher_profit
from titles;
```

### *p)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
select title, authors.au_fname, authors.au_lname, ytd_sales,price*ytd_sales as vendas, price*ytd_sales*royalty/100 as author_profit, price*ytd_sales-price*ytd_sales*royalty/100 as publisher_profit
from ((titles join titleauthor on titles.title_id=titleauthor.title_id) join authors on titleauthor.au_id=authors.au_id)
```

### *q)* Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
select stores.stor_id, stor_name
from ((titles join sales on titles.title_id=sales.title_id) join stores on sales.stor_id=stores.stor_id)
group by stores.stor_id, stor_name
having count(title)=(select count(title) from titles);
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
select stores.stor_id, stor_name
from ((titles join sales on titles.title_id=sales.title_id) join stores on sales.stor_id=stores.stor_id)
group by stores.stor_id, stor_name
having sum(sales.qty) > (select avg(total_sales) from
(select sum(sales.qty) as total_sales from sales group by sales.stor_id) as store_sales);
```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

```
(select titles.title_id, title
from titles)
except
(select titles.title_id, title
from ((titles join sales on titles.title_id=sales.title_id) join stores on sales.stor_id=stores.stor_id)
where stor_name='Bookbeat');
```

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

```
select distinct publishers.pub_name, stores.stor_name
from publishers, stores, titles
where publishers.pub_id = titles.pub_id and stores.stor_id not in (select sales.stor_id from sales where sales.title_id in (select title_id from titles where titles.pub_id = publishers.pub_id))
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_1_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_1_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
select Ssn, Fname, Lname, Pname, Pnumber
from ((Employee join Works_on on Works_on.Essn=Employee.Ssn) join Project on works_on.Pno=project.Pnumber )
```

##### *b)* 

```
select Employee.Fname, Employee.Minit, Employee.Lname
from (Employee join Employee as SuperVisor on Employee.Super_ssn=SuperVisor.Ssn)
where SuperVisor.Fname='Carlos' and SuperVisor.Minit='D' and SuperVisor.Lname='Gomes'
```

##### *c)* 

```
select Project.Pname, sum([Hours]) as TotalHours
from (Works_on join Project on Works_on.Pno=Project.Pnumber )
group by Project.Pname
```

##### *d)* 

```
select Fname, Minit, Lname, Dno, [Hours], Pname
from ((Employee join Works_on on Employee.Ssn=Works_on.Essn) join Project on Works_on.Pno=Project.Pnumber  )
where Dno=3 and Pname='Aveiro Digital' and [Hours]>20
```

##### *e)* 

```
Select e.Fname, e.Minit, e.Lname, e.Ssn
From employee e
LEFT OUTER JOIN works_on w on e.Ssn = w.Essn
Where w.Essn IS NULL
Except
Select e2.Fname, e2.Minit, e2.Lname, e2.Ssn
From employee e2
JOIN works_on w2 on e2.Ssn = w2.Essn
```

##### *f)* 

```
Select Department.Dname, avg(Salary) as FemSalaryAverage
from (Employee join Department on Dno=Dnumber)
where Employee.Sex='F'
group by Department.Dname 
```

##### *g)* 

```
Select Fname, count(Fname) as DependentsNum
from(Employee join [Dependent] on employee.Ssn=dependent.Essn)
group by Fname
having count(Fname)>2;
```

##### *h)* 

```
Select Dname, Fname, Minit, Lname
from ((Department join Employee on Ssn=Mgr_snn) left outer join [dependent] on Essn=Ssn)
Where Essn is null;
```

##### *i)* 

```
Select Distinct Fname, Minit, LName, [Address]
from(((Works_on join Project on works_on.Pno=Pnumber) join Employee on employee.Ssn=Essn) join Dept_locations on dept_locations.Dnumber=employee.Dno)
Where Plocation='Aveiro' and Dlocation!=Plocation;
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
select fornecedor.nome
from fornecedor left outer join encomenda on fornecedor.nif=encomenda.fornecedor
where encomenda.numero is null;
```

##### *b)* 

```
select codProd, avg(unidades) as TotalUnidades
from item
group by codProd;
```


##### *c)* 

```
select avg(cast (productcount as float)) as averageNumProducts 
from (select codProd, count(numEnc) as productcount
from item
group by codProd) as totalProducts
```


##### *d)* 

```
select fornecedor.nome, produto.nome, sum(item.unidades) as Quantidade
from (((fornecedor join encomenda on nif=fornecedor) join item on numEnc=numero) join produto on codigo=codProd)
group by fornecedor.nome, produto.nome
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_3_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_3_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
select paciente.nome
from (prescricao as Presc left outer join paciente on Presc.numUtente=paciente.numUtente)
where Presc.nomeFarmacia is null;
```

##### *b)* 

```
select medico.especialidade, count(prescricao.numPresc) as PrescricoesPerEspecialidade
from (medico join prescricao on numSNS=numMedico)
group by medico.especialidade
```


##### *c)* 

```
select nome, count(numPresc) as prescricaoProcessada
from (prescricao join farmacia on nomeFarmacia=nome)
group by nome;

```


##### *d)* 

```
select farmaco.FarmReg as FarmReg, farmaco.nome
from(farmaco left outer join presc_farmaco on farmaco.nome=nomeFarmaco )
where numPresc is null and farmaco.FarmReg=906;
```

##### *e)* 

```
select f.nome as farmacia_nome, pf.FarmReg, count(pf.FarmReg) as numFarmacos
from ((farmacia as f join prescricao as p on f.nome=p.nomeFarmacia) join presc_farmaco as pf on p.numPresc=pf.numPresc)
group by f.nome, pf.FarmReg
ORDER BY f.nome, pf.FarmReg;
```

##### *f)* 

```
select paciente.nome, count(medico.nome) as medicosDiferentes
from ((paciente join prescricao on paciente.numUtente=prescricao.numUtente) join medico on numSNS=numMedico)
group by paciente.nome
having count(medico.nome)>1
```
