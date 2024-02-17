# BD: Guião 5


## ​Problema 5.1
 
### *a)*

```
EMPLOYEE_PROJ = (works_on ⨝works_on.Essn=employee.Ssn employee)⨝works_on.Pno=project.Pnumber project
πSsn,Fname,Lname,Pname,Pnumber EMPLOYEE_PROJ
```


### *b)* 

```
π employee.Fname, employee.Minit, employee.Lname (employee ⨝employee.Super_ssn=Carlos.Ssn (ρ Carlos (π Ssn (σ employee.Fname='Carlos' ∧ employee.Minit='D' ∧ employee.Lname='Gomes' employee))))
```


### *c)* 

```
Splitted_hours = works_on ⨝works_on.Pno=project.Pnumber project
γ Pname; sum(Hours)->TotalHours Splitted_hours
```


### *d)* 

```
σ Dno=3 ∧ Pname='Aveiro Digital' ∧ Hours > 20 (π Fname, Minit, Lname, Dno, Hours, Pname ((employee ⨝employee.Ssn=works_on.Essn works_on)⨝works_on.Pno=project.Pnumber project))
```


### *e)* 

```
π Fname, Minit, Lname (employee ⟖ ((π Ssn employee) - (π Essn works_on)))
```


### *f)* 

```
Splitted_Salary = σ employee.Sex='F' (employee ⨝employee.Dno=department.Dnumber department)
γ department.Dname; avg(Salary)->FemSalaryAverage Splitted_Salary
```


### *g)* 

```
Family_table = (employee ⨝employee.Ssn=dependent.Essn dependent)
σ Num>2 (γ Fname; count(Fname)-> Num Family_table)
```


### *h)* 

```
((π department.Mgr_ssn department) - (π dependent.Essn dependent)) ⨝department.Mgr_ssn=employee.Ssn employee
```


### *i)* 

```
π Fname,Minit,Lname,Address (σ dept_location.Dlocation≠project.Plocation (dept_location ⨝dept_location.Dnumber=employee.Dno (employee ⨝employee.Ssn=Essn (works_on ⨝works_on.Pno=Pnumber (σ Plocation='Aveiro' project)))))
```


## ​Problema 5.2

### *a)*

```
π fornecedor.nome (σ encomenda.numero=null (fornecedor ⟕fornecedor=nif encomenda))
```

### *b)* 

```
γ codProd; avg(unidades) → TotalUnidades item
```


### *c)* 

```
γ avg(totalProducts) -> averageNumProducts (γ codProd ; count(numEnc) -> totalProducts (item))
```


### *d)* 

```
produtosFornecedor = π nome, unidades, codProd (item ⨝numEnc=numero (fornecedor ⨝nif=fornecedor encomenda))
γ fornecedor.nome, produto.nome ; sum(item.unidades) -> Quantidade (produto ⨝codigo=codProd produtosFornecedor)
```


## ​Problema 5.3

### *a)*

```
π nome (σ prescricao.farmacia=null (prescricao ⟕ paciente))
```

### *b)* 

```
γ medico.especialidade;count(prescricao.numPresc) -> PrescricoesPerEspecialidade (medico ⨝numSNS=numMedico prescricao)
```


### *c)* 

```
γ farmacia; count(numPresc) -> prescricaoProcessada (prescricao ⨝farmacia=nome farmacia)
```


### *d)* 

```
π nome (σ numPresc=null (σ numRegFarm=906 farmaco ⟕nome=nomeFarmaco presc_farmaco))
```

### *e)* 

```
PrescricaoPerFarmacia = (π nome, numPresc (farmacia ⨝nome=farmacia prescricao))
ProdutosFarmacia = (γ nome, numRegFarm ; count(numRegFarm) -> numFarmacos (presc_farmaco ⨝ PrescricaoPerFarmacia))
FarmacosPerFarmaceutica = farmaceutica ⨝ numReg=numRegFarm ProdutosFarmacia
π farmacia.nome,farmaceutica.nome,numFarmacos (FarmacosPerFarmaceutica)
```

### *f)* 

```
σ medicosDiferentes>1 (γ paciente.nome ; count(medico.nome) -> medicosDiferentes (π numSNS,medico.nome,paciente.nome (medico ⨝numSNS=numMedico (paciente ⨝paciente.numUtente=prescricao.numUtente prescricao))))
```
