create database empresa3;
use empresa3;

create table departamento(
	id_dept integer primary key auto_increment,
    nome_dept varchar(50),
    local_dept varchar(50),
    orcamento_dept decimal(10,2)
);

create table funcionario(
	id_func integer primary key auto_increment,
    nome_func varchar(100),
    salario_func decimal(10,2),
    id_dept integer,
    foreign key(id_dept) references departamento(id_dept)
);

insert into departamento(nome_dept, local_dept, orcamento_dept) values
("Financeiro", "Bloco A", 7000.00), ("Marketing", "Bloco B", 8000.00), ("Recursos Humanos", "Bloco C", 2000.00),
("T.I.", "Bloco D", 8000.00), ("Vendas", "Bloco E", 7000.00);

select * from departamento;

insert into funcionario(nome_func, salario_func, id_dept) values
("Aline Ferreira", 1300.00, 5), ("Diana Lima", 2000.00, 4), ("Felipe Campos", 1500.00, 3),
("Henrique Oliveira", 2100.00, 2), ("Matheus Silva", 1500.00, 1);

select * from funcionario;

-- Transação atual salva com COMMIT: aumento de salários

start transaction;

update departamento set orcamento_dept = orcamento_dept + 1000.00 where nome_dept = "T.I.";

update departamento set orcamento_dept = orcamento_dept + 1000.00 where nome_dept = "Financeiro";

commit;

select * from departamento;

-- Transação atual cancelada com ROLLBACK: redução de salários

start transaction;

update departamento set orcamento_dept = orcamento_dept - 5000.00 where nome_dept = "Marketing";

update departamento set orcamento_dept = orcamento_dept - 3000.00 where nome_dept = "Vendas";

rollback;

select * from departamento;

-- Ponto salvo na transação atual com SAVEPOINT: aumento de salários

start transaction;

update departamento set orcamento_dept = orcamento_dept + 7000.00 where nome_dept = "Recursos Humanos";

savepoint ajuste_parcial;

update departamento set orcamento_dept = orcamento_dept + 2000.00 where nome_dept = "Vendas";

rollback to ajuste_parcial;

commit;

select * from departamento;

-- Transação atual salva com COMMIT: aumento de salário

start transaction;

update funcionario set salario_func = salario_func + 1000.00 where nome_func = "Matheus Silva";

commit;

select * from funcionario;

-- Transação atual cancelada com ROLLBACK: atualização de nome

start transaction;

update funcionario set nome_func = "Alice Ferreira" where nome_func = "Aline Ferreira";

rollback;

select * from funcionario;

-- Ponto salvo na transação atual com SAVEPOINT: aumento de salário e alteração de nome

start transaction;

update funcionario set salario_func = salario_func + 1000.00 where id_func = 3;

savepoint ajuste_salario;

update funcionario set nome_func = "Filipe Campos" where nome_func = "Felipe Campos";

rollback to ajuste_salario;

select * from funcionario;