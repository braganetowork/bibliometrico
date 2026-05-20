# bibliometrico

Web service em R para fusão de bases bibliométricas (Scopus + Web of Science).

## Como usar

1. Acesse a URL do serviço
2. Faça upload do CSV do Scopus
3. Faça upload do TXT (savedrecs) do Web of Science
4. Clique em **JUNTAR BASES**
5. O arquivo `dadosbiblio.xlsx` será baixado automaticamente

## Deploy no Render.com

1. Suba este repositório no GitHub
2. Crie um novo **Web Service** no Render
3. Conecte o repositório
4. O Render detectará o `Dockerfile` e `render.yaml` automaticamente
5. Clique em **Deploy**

> O primeiro build pode levar ~10-15 min devido à instalação
> do `bibliometrix` e suas dependências.
