CREATE TABLE Pacientes (
    id_paciente INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    sexo CHAR(1),
    cpf VARCHAR(14) UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100)
);
CREATE TABLE Medicos (
    id_medico INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    crm VARCHAR(20) UNIQUE,
    email VARCHAR(100),
    telefone VARCHAR(20)
);
CREATE TABLE Consultas (
    id_consulta INT PRIMARY KEY IDENTITY(1,1),
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data_consulta DATETIME,
    diagnostico VARCHAR(255),
    observacoes VARCHAR(MAX),
    CONSTRAINT FK_Consultas_Pacientes
        FOREIGN KEY (id_paciente)
        REFERENCES Pacientes(id_paciente),
    CONSTRAINT FK_Consultas_Medicos
        FOREIGN KEY (id_medico)
        REFERENCES Medicos(id_medico)
);
CREATE TABLE Exames (
    id_exame INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(MAX),
    preco DECIMAL(10,2)
);
CREATE TABLE Solicitacoes_Exames (
    id_solicitacao INT PRIMARY KEY IDENTITY(1,1),
    id_consulta INT NOT NULL,
    id_exame INT NOT NULL,
    data_solicitacao DATE,
    status VARCHAR(20),
    CONSTRAINT FK_Solicitacoes_Consultas
        FOREIGN KEY (id_consulta)
        REFERENCES Consultas(id_consulta),
    CONSTRAINT FK_Solicitacoes_Exames
        FOREIGN KEY (id_exame)
        REFERENCES Exames(id_exame)
);


SELECT
    p.nome AS paciente,
    c.data_consulta
FROM Consultas c
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
WHERE MONTH(c.data_consulta) = 9;


SELECT
    p.nome AS paciente,
    m.nome AS medico,
    c.data_consulta,
    c.diagnostico,
    c.observacoes
FROM Consultas c
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
INNER JOIN Medicos m
    ON c.id_medico = m.id_medico;

SELECT
    p.nome AS paciente,
    e.nome AS exame,
    se.data_solicitacao
FROM Solicitacoes_Exames se
INNER JOIN Consultas c
    ON se.id_consulta = c.id_consulta
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
INNER JOIN Exames e
    ON se.id_exame = e.id_exame
WHERE c.data_consulta >= DATEADD(MONTH, -1, GETDATE());


SELECT
    p.nome AS paciente,
    c.data_consulta,
    c.diagnostico
FROM Consultas c
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
INNER JOIN Medicos m
    ON c.id_medico = m.id_medico
WHERE m.nome = 'Dr. João Silva'
AND c.data_consulta BETWEEN '2025-01-01' AND '2025-12-31';


SELECT
    e.nome AS exame,
    p.nome AS paciente,
    c.data_consulta
FROM Solicitacoes_Exames se
INNER JOIN Exames e
    ON se.id_exame = e.id_exame
INNER JOIN Consultas c
    ON se.id_consulta = c.id_consulta
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
WHERE se.status = 'Pendente';


SELECT
    p.nome AS paciente,
    m.nome AS medico,
    c.diagnostico
FROM Consultas c
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
INNER JOIN Medicos m
    ON c.id_medico = m.id_medico
WHERE c.data_consulta
BETWEEN '2025-01-01' AND '2025-03-31';


SELECT
    p.nome
FROM Pacientes p
LEFT JOIN Consultas c
    ON p.id_paciente = c.id_paciente
WHERE c.id_consulta IS NULL;


SELECT
    p.nome AS paciente,
    e.nome AS exame,
    c.data_consulta,
    m.nome AS medico
FROM Solicitacoes_Exames se
INNER JOIN Consultas c
    ON se.id_consulta = c.id_consulta
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
INNER JOIN Medicos m
    ON c.id_medico = m.id_medico
INNER JOIN Exames e
    ON se.id_exame = e.id_exame
WHERE se.status = 'Realizado'
AND p.nome = 'Maria Souza';


SELECT
    p.nome AS paciente,
    c.data_consulta,
    c.diagnostico
FROM Consultas c
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
INNER JOIN Medicos m
    ON c.id_medico = m.id_medico
WHERE m.nome = 'Dra. Ana Lima'
AND c.data_consulta
BETWEEN '2025-04-01' AND '2025-04-30';


SELECT
    e.nome AS exame,
    p.nome AS paciente,
    m.nome AS medico
FROM Solicitacoes_Exames se
INNER JOIN Consultas c
    ON se.id_consulta = c.id_consulta
INNER JOIN Exames e
    ON se.id_exame = e.id_exame
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
INNER JOIN Medicos m
    ON c.id_medico = m.id_medico
WHERE c.diagnostico = 'Hipertensão';


SELECT
    p.nome AS paciente,
    e.nome AS exame,
    se.status
FROM Solicitacoes_Exames se
INNER JOIN Consultas c
    ON se.id_consulta = c.id_consulta
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
INNER JOIN Exames e
    ON se.id_exame = e.id_exame;


SELECT
    m.nome AS medico,
    p.nome AS paciente,
    c.data_consulta
FROM Consultas c
INNER JOIN Pacientes p
    ON c.id_paciente = p.id_paciente
INNER JOIN Medicos m
    ON c.id_medico = m.id_medico
WHERE c.diagnostico = 'Gripe';
