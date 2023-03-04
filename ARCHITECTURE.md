# Arquitetura

(Geralmente é um documento escrito em inglês)

# Objetivo

Esse documento tem por objetivo principal organizar o processo de desenvolvimento do software.

# Regras iniciais, limite e Análise

Pontos a serem levados em consideração antes de introduzir uma nova feature:

- Esse projeto deve ter cobertura mínima de testes de no mínimo 70%.
- Camadas globais devem ter um lugar específico na aplicação, por tanto, devem estar na pasta Shared.
- Cada feature deverá ter sua própria pasta onde conterá todas as camadas necessárias para a execução dos casos de uso da feature.
- Todos os designs patterns usados no projeto devem estar listados na sessão “Design Patterns” desse documento, caso contrário será considerado implementação errônea.
- Packages e plugins novos só poderão ser usados nos projetos após avaliação e aprovação de toda equipe responsável pelo projeto.
- Atualizações no Modelo de domínio só poderão ser aceitas se primeiro for adicionada nesse documento e aprovado por todos os envolvidos no projeto.
- Não é permitido ter uma classe concreta como dependência de uma camada. Só será aceita coesão com classes abstratas ou interfaces. Com exceção da Store.
- Cada camada deve ter apenas uma responsabilidade.



# Entidades


# Casos de Uso


# Design Patterns

- Repository Pattern: Para acesso a API externa.
- Service Pattern: Para isolar trechos de códigos com outras responsabilidades.
- Dependency Injection: Resolver dependências das classes.
- Store: Guardar e mudar estados.
- State pattern: Padrão que auxilia no gerenciamento estados.
- Adapter: Converter um objeto em outro.
- Result: Trabalhar com retorno Múltiplo.


# Package externos (Comum)

- Mocktail: Para testes de unidade.
- dartz: Retorno múltiplo no formato Failure e Success.
- intl: Fornece facilidades de internacionalização e localização.
- http: Cliente HTTP.

# Package externos (App)

- flutter_modular: Modularização de rotas e injeção de dependências.
- shared_preferences: Reproduzir animações personalizadas. 
- flutter_modular: Auxiliar a modularização do app. 
- table_calendar: Disponibilizar uma calendario.
- equatable: Simplificar as comparações de igualdade.
- flutter_dotenv: Disponibilizar ambientes para o desenvolvimento. 
- rive: Reproduzir animações personalizadas. 
- flutter_svg: Reproduzir svgs personalizados. 

# Package externos (Backend)


