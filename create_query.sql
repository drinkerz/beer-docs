-- -----------------------------------------------------
-- Table `drinkerz_database`.`style_master`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drinkerz_database`.`style_master` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drinkerz_database`.`beer_master`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drinkerz_database`.`beer_master` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `style` VARCHAR(45) NOT NULL COMMENT '맥주 스타일 (ale, lager, lambic)',
  `brand` VARCHAR(45) NULL COMMENT '어디서 만든 맥주인지',
  `country` VARCHAR(45) NULL COMMENT '어느나라 맥주인지',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `name_idx` (`style` ASC) ,
  CONSTRAINT `name`
    FOREIGN KEY (`style`)
    REFERENCES `drinkerz_database`.`style_master` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drinkerz_database`.`beer_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drinkerz_database`.`beer_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `beerId` INT NOT NULL COMMENT '맥주 아이디',
  `abv` INT NOT NULL COMMENT 'Alcohol By Volume, 알콜 도수',
  `ibu` INT NULL COMMENT 'International Bittering Units, 맥주의 쓰기',
  `srm` INT NULL COMMENT 'Standard Reference Method, 맥주의 색',
  `style` VARCHAR(45) NULL COMMENT '맥주 스타일인데 더 상세한 스타일 (pale ale, fruit ale 같이 ale의 하위에 대한 것을 나타냄)',
  PRIMARY KEY (`id`, `beerId`),
  INDEX `beerid_idx` (`beerId` ASC) ,
  CONSTRAINT `id`
    FOREIGN KEY (`beerId`)
    REFERENCES `drinkerz_database`.`beer_master` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drinkerz_database`.`user_master`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drinkerz_database`.`user_master` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL COMMENT '암호화된 비밀번호',
  `nickname` VARCHAR(45) NOT NULL COMMENT '별명',
  `country` VARCHAR(45) NULL COMMENT '어느나라 사람',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nickname_UNIQUE` (`nickname` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drinkerz_database`.`review_master`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drinkerz_database`.`review_master` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reviewerId` INT NOT NULL,
  `beerId` INT NOT NULL,
  PRIMARY KEY (`id`, `reviewerId`, `beerId`),
  INDEX `id_idx` (`reviewerId` ASC) ,
  INDEX `id_idx1` (`beerId` ASC) ,
  CONSTRAINT `fk_review_id`
    FOREIGN KEY (`reviewerId`)
    REFERENCES `drinkerz_database`.`user_master` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_beer_id`
    FOREIGN KEY (`beerId`)
    REFERENCES `drinkerz_database`.`beer_master` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drinkerz_database`.`review_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drinkerz_database`.`review_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reviewId` INT NULL,
  `text` BLOB NULL COMMENT '리뷰 내용',
  `look` INT NULL DEFAULT 0 COMMENT '보기점수\n음 보기에 너무 오줌색같아서 먹기 꺼려지는데 그런거 같음',
  `smell` INT NULL DEFAULT 0 COMMENT '냄새에 대한 점수',
  `taste` INT NULL DEFAULT 0 COMMENT '맛에 대한 점수',
  `feel` INT NULL DEFAULT 0 COMMENT '먹었을 때의 느낌\n풍성함 같은것?',
  `price` INT NULL DEFAULT 0 COMMENT '가격에 대한 점수\n아 겁나 비싸네, 이렇게 맛있는데 이 가격이야? 를 수치화',
  `overall` INT NULL DEFAULT 0 COMMENT '전체적으로 점수',
  `created_date` DATETIME NULL DEFAULT NOW() COMMENT '리뷰 등록 날짜',
  `update_date` DATETIME NULL COMMENT '수정 날짜',
  PRIMARY KEY (`id`),
  INDEX `id_idx` (`reviewId` ASC) ,
  CONSTRAINT `fk_review_detail_id`
    FOREIGN KEY (`reviewId`)
    REFERENCES `drinkerz_database`.`review_master` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `drinkerz_database`.`style_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `drinkerz_database`.`style_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `styleId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL COMMENT 'style_master 이름이 ale 인 경우 pale ale 같은 이름이 저장된다.',
  `feature` BLOB NULL,
  PRIMARY KEY (`id`, `styleId`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) ,
  INDEX `id_idx` (`styleId` ASC) ,
  CONSTRAINT `fk_style_id`
    FOREIGN KEY (`styleId`)
    REFERENCES `drinkerz_database`.`style_master` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

