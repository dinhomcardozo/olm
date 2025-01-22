Autenticação: Gem Devise para autenticação de SystemAdmin e Users.
Autorização: Gem Pundit para definir permissões entre SystemAdmin, ClientAdmin, e User.
Front-end:
Hotwire/Stimulus para interatividade (ex.: lightbox e drag and drop).
Gem TailwindCSS para estilização.
PDF: Gem Prawn ou wicked_pdf para geração de contratos e cotações.
Relatórios: Gem Chartkick com Groupdate para visualização gráfica.

Página Inicial: app\views\dashboard\index.html.erb - Exibe os stages e as opportunities de cada um deles
app\views\dashboard\_stage.html.erb - Renderiza os stages
app\views\dashboard\_opportunity.html.erb - Renderiza a opp resumida dentro dos stages