# Gestão Pessoal — .NET + Ionic

Ambiente de desenvolvimento reproduzível para trabalhar no backend .NET e no app Ionic usando VS Code Dev Containers ou GitHub Codespaces.

## Ambiente incluído

- .NET SDK 10 (LTS) para ASP.NET Core / Web API.
- Node.js 24 e npm.
- Ionic CLI.
- Java 21 para ferramentas do ecossistema Android.
- Entity Framework Core CLI (`dotnet-ef`).
- Extensões do VS Code para C#, .NET, Ionic/Angular, ESLint, Prettier, GitLens e chamadas HTTP.
- Portas encaminhadas para Ionic e ASP.NET Core.

## Abrir o ambiente

1. Abra o repositório no VS Code.
2. Instale a extensão **Dev Containers**, caso ainda não esteja instalada.
3. Execute **Dev Containers: Reopen in Container** na paleta de comandos.
4. Aguarde a criação do container e a execução de `.devcontainer/post-create.sh`.

O mesmo `.devcontainer/devcontainer.json` pode ser usado pelo GitHub Codespaces.

## Verificar as ferramentas

```bash
dotnet --info
node --version
npm --version
ionic --version
dotnet ef --version
java -version
```

## Criar a solução quando estiver pronto

O repositório começa com a configuração do ambiente. A estrutura de aplicação pode ser criada em uma etapa separada, evitando misturar a configuração do container com decisões de arquitetura.

Sugestão inicial:

- `src/backend/`: API ASP.NET Core.
- `src/frontend/`: Ionic + Angular + Capacitor.
- `tests/`: testes automatizados do backend e frontend.

Exemplo para criar o backend:

```bash
mkdir -p src/backend src/frontend tests
dotnet new webapi -n GestaoPessoal.Api -o src/backend/GestaoPessoal.Api
```

Exemplo para criar o frontend Ionic Angular:

```bash
cd src
ionic start frontend blank --type=angular --capacitor
```

> O comando de criação do Ionic pode fazer perguntas interativas e baixar dependências.

## Plugins Capacitor recomendados

Instale dependências nativas no diretório do app depois de criar o projeto. Os plugins devem ser versionados no `package.json` do frontend, não instalados globalmente no container.

```bash
cd src/frontend
npm install @capacitor/app @capacitor/haptics @capacitor/keyboard @capacitor/status-bar
```

Outros plugins devem ser adicionados quando houver necessidade concreta, por exemplo:

- `@capacitor/preferences`: preferências simples.
- `@capacitor/network`: estado da conexão.
- `@capacitor/camera`: captura de imagens.
- `@capacitor/local-notifications`: notificações locais.
- Um plugin de armazenamento seguro mantido e compatível com a versão do Capacitor, após avaliar manutenção e suporte às plataformas desejadas.

Para dados financeiros e funcionamento offline, prefira um banco local apropriado e defina uma estratégia explícita de sincronização. Não armazene senhas, tokens ou dados financeiros sensíveis em preferências sem proteção.

## Observações

- Java está incluído, mas o Android SDK/emulador e os certificados de assinatura de release não são configurados por este container inicial.
- Para compilar/rodar no Android, configure o Android SDK e use um dispositivo físico ou emulador compatível. Builds iOS exigem macOS e Xcode.
- Nunca comite credenciais, arquivos `.env`, keystores ou tokens.
