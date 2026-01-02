# Introdução à Análise de Dados em Saúde com PySpark

Este repositório contém materiais práticos para **análise de dados em larga escala utilizando PySpark**, com foco em **dados do SUS (DATASUS / SIM)**. Ele é voltado a estudantes, pesquisadores e profissionais de saúde pública que desejam trabalhar com **big data**, pipelines distribuídos e análises reprodutíveis em ambientes locais ou em nuvem.

O conteúdo é uma **adaptação do curso “Introdução à Análise de Dados para Pesquisa no SUS”**, originalmente baseado em R, agora reestruturado para **Apache Spark + Python (PySpark)**.

---

## 📚 ESTRUTURA DO REPOSITÓRIO

O repositório está organizado em **módulos progressivos**, do básico ao avançado:

| Módulo | Tema | Status |
|------|------|--------|
| **Módulo 1** | Fundamentos de PySpark e DataFrames | ✅ |
| **Módulo 2** | Análise Exploratória e Estatística Descritiva | ✅ |
| **Módulo 3** | Engenharia de Dados e Modelagem | ⏳ |

---

## 📁 ESTRUTURA DE PASTAS

```text
.
├── data/
│   ├── raw/              # Dados brutos (DATASUS, SIM, etc.)
│   ├── processed/        # Dados tratados
│   └── dictionary/       # Dicionários de dados
│
├── notebooks/            # Notebooks Jupyter (exploração e estudo)
│
├── src/
│   ├── ingestion/        # Leitura e padronização de dados
│   ├── transformation/   # Limpeza e transformação
│   ├── analysis/         # Análises estatísticas
│   └── utils/            # Funções utilitárias
│
├── tests/                # Testes automatizados
├── requirements.txt      # Dependências do projeto
└── README.md
```

---

## 📊 DADOS UTILIZADOS

Os exemplos utilizam dados do **Sistema de Informações sobre Mortalidade (SIM)**, em diferentes formatos.

| Arquivo | Formato | Descrição |
|------|------|-----------|
| `sim_salvador_2023.csv` | CSV | Dados originais do SIM |
| `sim_salvador_2023.parquet` | Parquet | Dataset otimizado para Spark |
| `sim_salvador_2023_processado.parquet` | Parquet | Dados tratados |
| `dicionario_sim.pdf` | PDF | Dicionário de variáveis |

### Principais variáveis

- **SEXO** – sexo do indivíduo
- **DTOBITO** – data do óbito (`ddMMyyyy`)
- **DTNASC** – data de nascimento
- **IDADE** – idade codificada (padrão DATASUS)
- **CAUSABAS** – causa básica (CID-10)
- **CODMUNRES** – município de residência (IBGE)

---

## 🎯 OBJETIVOS DE APRENDIZAGEM

### Módulo 1 – Fundamentos de PySpark

- Criação de `SparkSession`
- Leitura de dados CSV, Parquet e JSON
- Uso de `DataFrame`, `select`, `withColumn`, `filter`
- Tipagem de dados e tratamento de datas
- Boas práticas em Spark

### Módulo 2 – Estatística Descritiva Distribuída

- Agregações com `groupBy` e `agg`
- Estatísticas descritivas em grandes volumes
- Análise temporal (ano, mês, séries históricas)
- Integração com Pandas para visualização
- Exportação de resultados

### Módulo 3 – Engenharia de Dados e Modelagem

- Pipelines ETL com PySpark
- Particionamento e otimização
- Validação e qualidade dos dados
- Integração com dashboards (React / APIs)
- Preparação de dados para modelos preditivos

---

## 🚀 COMO EXECUTAR O PROJETO

### 1. Pré-requisitos

- Python 3.10+
- Java 8 ou 11
- Apache Spark 3.x

### 2. Criar ambiente virtual

```bash
python -m venv .venv
source .venv/bin/activate
```

### 3. Instalar dependências

```bash
pip install -r requirements.txt
```

### 4. Exemplo básico de execução

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("SIM Analysis") \
    .getOrCreate()

df = spark.read.parquet("data/processed/sim_salvador_2023.parquet")
df.show(5)
```

---

## 🧪 TRATAMENTO DE DATAS (EXEMPLO REAL)

```python
from pyspark.sql.functions import col, lpad, to_date, year

df = df.withColumn(
    "DTOBITO_clean",
    lpad(col("DTOBITO").cast("string"), 8, "0")
).withColumn(
    "DTOBITO_dt",
    to_date(col("DTOBITO_clean"), "ddMMyyyy")
).withColumn(
    "ano_obito",
    year(col("DTOBITO_dt"))
)
```

Esse padrão é amplamente utilizado em bases do **DATASUS**, onde datas frequentemente perdem zeros à esquerda.

---

## 🔧 BOAS PRÁTICAS EM PYSPARK

- Prefira **Parquet** a CSV
- Evite `collect()` em grandes volumes
- Use `select` em vez de carregar todas as colunas
- Trate schemas explicitamente quando possível
- Separe ingestão, transformação e análise

---

## 🔗 REFERÊNCIAS E MATERIAIS DE APOIO

### Documentação

- Apache Spark: https://spark.apache.org/docs/latest/
- PySpark API: https://spark.apache.org/docs/latest/api/python/

### Dados de Saúde

- DATASUS – https://datasus.saude.gov.br/
- OpenDataSUS – https://opendatasus.saude.gov.br/

### Engenharia de Dados

- Designing Data-Intensive Applications – Martin Kleppmann
- Spark: The Definitive Guide – Bill Chambers

---

## 📖 COMO CITAR

> Introdução à Análise de Dados em Saúde com PySpark. (2025). Repositório GitHub. Brasil.

---

## 🙏 CRÉDITOS

Base conceitual inspirada no curso **Introdução à Análise de Dados para Pesquisa no SUS** – Fiocruz.

Dados: **Sistema de Informações sobre Mortalidade (SIM) – DATASUS**

---

**Versão:** 1.0  
**Última atualização:** Dezembro/2025

