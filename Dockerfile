# Use uma imagem oficial do Python como imagem base.
# A versão alpine é leve, o que é ótimo para produção.
FROM python:3.12.11-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho
COPY requirements.txt .

# Instala as dependências do projeto
# --no-cache-dir: Desabilita o cache do pip para manter a imagem menor.
# --upgrade pip: Garante que estamos usando a versão mais recente do pip.
RUN pip install --no-cache-dir --upgrade pip -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que o uvicorn será executado
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar
# Usamos "0.0.0.0" para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]