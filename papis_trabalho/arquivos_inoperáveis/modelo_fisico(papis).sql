CREATE DATABASE papis_db  
USE papis_db;

CREATE TABLE usuario (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  senha_hash VARCHAR(15) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE contrato (
  id_contrato INT AUTO_INCREMENT PRIMARY KEY,
  numero VARCHAR(40) NOT NULL UNIQUE,
  empresa VARCHAR(180) NOT NULL,
  valor DECIMAL NOT NULL,
  data_inicio DATE NOT NULL,
  data_fim DATE NOT NULL,
  id_usuario INT NULL,
  CONSTRAINT chk_contrato_valor CHECK (valor >= 0),
  CONSTRAINT chk_contrato_vigencia CHECK (data_fim >= data_inicio),
  CONSTRAINT fk_contrato_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE documento (
  id_documento INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  tipo VARCHAR(50) NOT NULL,
  data_envio DATE NOT NULL,
  descricao TEXT NOT NULL,
  arquivo_caminho VARCHAR(500) NULL,
  id_usuario INT NULL,
  id_contrato INT NULL,
  CONSTRAINT fk_documento_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_documento_contrato FOREIGN KEY (id_contrato)
    REFERENCES contrato(id_contrato) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE funcionario (
  id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
  cpf CHAR(11) NOT NULL UNIQUE,
  nome VARCHAR(100) NOT NULL,
  cargo VARCHAR(50) NOT NULL,
  salario_base DECIMAL NOT NULL,
  CONSTRAINT chk_funcionario_salario CHECK (salario_base >= 0)
) ENGINE=InnoDB;

CREATE TABLE folha_pagamento (
  id_folha INT AUTO_INCREMENT PRIMARY KEY,
  competencia CHAR(7) NOT NULL,
  data_elaboracao DATE NULL,
  id_usuario INT NULL,
  CONSTRAINT chk_folha_competencia
    CHECK (competencia REGEXP '^[0-9]{4}-(0[1-9]|1[0-2])$'),
  CONSTRAINT fk_folha_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE item_folha (
  id_item INT AUTO_INCREMENT PRIMARY KEY,
  id_folha INT NOT NULL,
  id_funcionario INT NOT NULL,
  salario_bruto DECIMAL NOT NULL,
  descontos DECIMAL NOT NULL,
  salario_liquido DECIMAL NOT NULL,
  CONSTRAINT chk_item_bruto CHECK (salario_bruto >= 0),
  CONSTRAINT chk_item_descontos CHECK (descontos >= 0),
  CONSTRAINT chk_item_liquido CHECK (salario_liquido >= 0),
  CONSTRAINT uq_item_folha_funcionario UNIQUE (id_folha, id_funcionario),
  CONSTRAINT fk_item_folha_folha FOREIGN KEY (id_folha)
    REFERENCES folha_pagamento(id_folha) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_item_folha_funcionario FOREIGN KEY (id_funcionario)
    REFERENCES funcionario(id_funcionario) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE tributo (
  id_tributo INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL UNIQUE,
  descricao TEXT NOT NULL,
  aliquota DECIMAL NOT NULL,
  CONSTRAINT chk_tributo_aliquota CHECK (aliquota >= 0)
) ENGINE=InnoDB;

CREATE TABLE calculo_tributo (
  id_calculo INT AUTO_INCREMENT PRIMARY KEY,
  id_tributo INT NOT NULL,
  data_calculo DATE NOT NULL,
  base_calculo DECIMAL NOT NULL,
  aliquota_aplicada DECIMAL NOT NULL,
  valor_calculado DECIMAL NOT NULL,
  CONSTRAINT chk_calculo_base CHECK (base_calculo >= 0),
  CONSTRAINT chk_calculo_aliquota CHECK (aliquota_aplicada >= 0),
  CONSTRAINT chk_calculo_valor CHECK (valor_calculado >= 0),
  CONSTRAINT fk_calculo_tributo FOREIGN KEY (id_tributo)
    REFERENCES tributo(id_tributo) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE parecer (
  id_parecer INT AUTO_INCREMENT PRIMARY KEY,
  numero VARCHAR(60) NOT NULL UNIQUE,
  titulo VARCHAR(100) NOT NULL,
  data_elaboracao DATE NOT NULL,
  conteudo LONGTEXT NOT NULL,
  id_contrato INT NULL,
  id_usuario INT NULL,
  CONSTRAINT fk_parecer_contrato FOREIGN KEY (id_contrato)
    REFERENCES contrato(id_contrato) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT fk_parecer_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE INDEX idx_documento_data ON documento(data_envio);
CREATE INDEX idx_contrato_empresa ON contrato(empresa);
CREATE INDEX idx_folha_competencia ON folha_pagamento(competencia);
CREATE INDEX idx_calculo_data ON calculo_tributo(data_calculo);
CREATE INDEX idx_parecer_data ON parecer(data_elaboracao);