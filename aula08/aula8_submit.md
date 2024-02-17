# BD: Guião 8


## ​8.1. Complete a seguinte tabela.
Complete the following table.

| #    | Query                                                                                                      | Rows  | Cost  | Pag. Reads | Time (ms) | Index used | Index Op.            | Discussion |
| :--- | :--------------------------------------------------------------------------------------------------------- | :---- | :---- | :--------- | :-------- | :--------- | :------------------- | :--------- |
| 1    | SELECT * from Production.WorkOrder                                                                         | 72591 | 0.484 | 531        | 1171      | WorkOrderID          | Clustered Index Scan |            |
| 2    | SELECT * from Production.WorkOrder where WorkOrderID=1234                                                  |   1    |0.000       | 20           | 35          | WorkOrderID           | Clustered Index Seek                     |            |
| 3.1  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 10000 and 10010                               | 11      | 0.000      | 20           | 57          | WorkOrderID          | Clustered Index Seek                     |            |
| 3.2  | SELECT * FROM Production.WorkOrder WHERE WorkOrderID between 1 and 72591                                   |   72591    |  0.080     |   808         |    1236       |   WorkOrderID |     Clustered Index Seek          | 
| 4    | SELECT * FROM Production.WorkOrder WHERE StartDate = '2007-06-25'                                          | 72591      | 0.080      | 554           | 29          | WorkOrderID           | Clustered Index Scan                     |            |
| 5    | SELECT * FROM Production.WorkOrder WHERE ProductID = 757                                                   | 9      | 0.000      | 44           | 41          | ProductID           | NonClustered Index Seek + Clustered                    |            |
| 6.1  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 757                              | 9      | 0.000      | 238           | 26          | 	ProductID (Covered)?          | NonClustered Index Seek + Clustered                    |            |
| 6.2  | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945                              |  72591     |    0.080   |     808       |      171     |     WorkOrderID       | Clustered Index Scan
| 6.3  | SELECT WorkOrderID FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04'            | 72591      | 0.080      | 556           | 12          | WorkOrderID           | Clustered Index Scan                     |            |
| 7    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' | 72591      | 0.080      | 750           |16          | WorkOrderID           |  	Clustered Index Scan                    |            |
| 8    | SELECT WorkOrderID, StartDate FROM Production.WorkOrder WHERE ProductID = 945 AND StartDate = '2006-01-04' | 72591      | 0.080      | 750           | 35          |            | Clustered Index Scan                     |            |

## ​8.2.

### a)

```
Create unique clustered index ridindex on mytemp(rid)
```

### b)

```
Inserted      50000 total records
Milliseconds used: 48583
Fragmentação dos índices: 99.52 %
Ocupação das percentagens dos índices: 68.94 %

```

### c)

```
Create unique clustered index ridindex_1 on mytemp(rid) with (fillfactor=65, pad_index=on)

fillfactor: 65
Inserted      50000 total records
Milliseconds used: 55536
Fragmentação dos índices: 98.98 %
Ocupação das percentagens dos índices: 65.33 %

Create unique clustered index ridindex_1 on mytemp(rid) with (fillfactor=80, pad_index=on)

fillfactor: 80
Inserted      50000 total records
Milliseconds used: 66863
Fragmentação dos índices: 98.78 %
Ocupação das percentagens dos índices: 60.23 %

Create unique clustered index ridindex_1 on mytemp(rid) with (fillfactor=90, pad_index=on)

fillfactor: 90
Inserted      50000 total records
Milliseconds used: 75633
Fragmentação dos índices: 99.08 %
Ocupação das percentagens dos índices: 60.24 %
```

### d)

```
Create unique clustered index ridindex_1 on mytemp(rid) with (fillfactor=65, pad_index=on)

fillfactor: 65
Inserted      50000 total records
Milliseconds used: 55536
Fragmentação dos índices: 98.92 %
Ocupação das percentagens dos índices: 68.77 %

Create unique clustered index ridindex_1 on mytemp(rid) with (fillfactor=80, pad_index=on)

fillfactor: 80
Inserted      50000 total records
Milliseconds used: 53936
Fragmentação dos índices: 99.25 %
Ocupação das percentagens dos índices: 78.30 %

Create unique clustered index ridindex_1 on mytemp(rid) with (fillfactor=90, pad_index=on)

fillfactor: 90
Inserted      50000 total records
Milliseconds used: 57273
Fragmentação dos índices: 99.14 %
Ocupação das percentagens dos índices: 67.59 %
```

### e)

```
Inserted      50000 total records
Milliseconds used: 111423

A criação de demasiados indices numa tabela fez com que se consumisse mais tempo a fazer a manutenção dos mesmos.
```

## ​8.3.

```
a)
i - Create unique clustered index PK_Ssn on employee(Ssn)
ii - Create index IX_FullName on employee(Fname, Lname)
iii - Create index IX_DNumber on employee(Dno)
    Create unique clustered index PK_DNumber on department(Dnumber)
iv - Create unique clustered index PK_Essn_Pno on works_on(Essn, Pno)
    Create unique clustered index PK_Ssn on employee(Ssn)
    Create unique clustered index PK_Pnumber on project(Pnumber)
v - Create unique clustered index PK_Ssn on employee(Ssn)
    Create unique clustered index PK_Essn_DepName on Dependent(Essn, Dependent_name)
vi - Create index IX_DNumber on project(Dnum)
    Create unique clustered index PK_DNumber on department(Dnumber)
```
