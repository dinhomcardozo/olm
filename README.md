ABOUT OLM: -----------------------------------------------------------------------------------/

This is a CRM project focused on Onboarding, Sales Process and Customer Retention.

Its process is quite simple, although very complete.

Its main features include:

- Customer Journey in a general and simplified Pipeline;
- Intuitive stages to generate more efficiency in the sales and relationship process;
- System with grouping of companies (Groups and Companies) for better control of opportunities;
- Stages focused on sales (Prospect, Lead, Demonstration, Quote and Sale);
- Stages focused on relationship (Post-sales and About to renew);
- Stages focused on retention (Renewed and Not renewed);
- Cascading features, where the user uses opportunity data to easily generate budgets, orders and contracts.

STACK: -----------------------------------------------------------------------------------/

ruby 3.3.6 (2024-11-05 revision 75015d4c1f) [x64-mingw-ucrt]
rails 8.0.1 
node v22.12.0
yarn 1.22.22
docker

Autenticação: Gem Devise para autenticação de SystemAdmin e Users. (Soon)
Autorização: Gem Pundit para definir permissões entre SystemAdmin, ClientAdmin, e User. (Soon)
Front-end:
Hotwire/Stimulus para interatividade (ex.: lightbox e drag and drop).
Gem TailwindCSS para estilização.
PDF: Gem Prawn ou wicked_pdf para geração de contratos e cotações.
Relatórios: Gem Chartkick com Groupdate para visualização gráfica.

ROUTES: 

Página Inicial: app\views\dashboard\index.html.erb - Exibe os stages e as opportunities de cada um deles
app\views\dashboard\_stage.html.erb - Renderiza os stages
app\views\dashboard\_opportunity.html.erb - Renderiza a opp resumida dentro dos stages