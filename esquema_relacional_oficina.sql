-- drop database oficina;

create database Oficina;
use Oficina;
-- -----------------------------------------------------
-- Table 'Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `NomeCliente` VARCHAR(60) NOT NULL,
  `Contato` CHAR(11) NOT NULL,
  `Endereco` VARCHAR(60) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  PRIMARY KEY (`idCliente`));
  
  alter table Cliente auto_increment=1;


-- -----------------------------------------------------
-- Table `Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Descricao` VARCHAR(255) NOT NULL,
  `NivelUrgencia` ENUM('baixa', 'media', 'alta') NULL DEFAULT 'baixa',
  `Liberado` ENUM('sim', 'nao') NULL DEFAULT 'nao',
  `TipoServico` ENUM('Manutencao', 'periodica') NULL DEFAULT 'periodica',
  `Cliente_idCliente` INT,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`));

alter table Pedido auto_increment=1;

-- -----------------------------------------------------
-- Table `Responsável`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Responsavel` (
  `idResponsavel` INT NOT NULL,
  `NomeResp` VARCHAR(45) NOT NULL,
  `Departamento` ENUM('motor', 'pintura', 'rodas') NULL,
  PRIMARY KEY (`idResponsavel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ordem de serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OrdemServico` (
  `idOrdemServico` INT NOT NULL AUTO_INCREMENT,
  `StatusDaOS` ENUM('Na fila', 'Em andamento', 'Liberada') NULL DEFAULT 'Na fila',
  `Pedido_idPedido` INT,
  PRIMARY KEY (`idOrdemServico`, `Pedido_idPedido`),
  INDEX `fk_OrdemServico_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_OrdemServico_Pedido1` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido` (`idPedido`));

alter table OrdemServico auto_increment=1;

-- -----------------------------------------------------
-- Table `ResponsaveisPedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ResponsaveisPedidos` (
  `Pedido_idPedido` INT,
  `Responsavel_idResponsavel` INT,
  PRIMARY KEY (`Pedido_idPedido`, `Responsavel_idResponsavel`),
  INDEX `fk_Pedido_has_Responsavel_Responsavel1_idx` (`Responsavel_idResponsavel` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Responsavel_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Responsavel_Pedido1` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido` (`idPedido`),
  CONSTRAINT `fk_Pedido_has_Responsavel_Responsavel1` FOREIGN KEY (`Responsavel_idResponsavel`) REFERENCES `Responsavel` (`idResponsavel`));
