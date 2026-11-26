# Trabalho do Papis

Sistema web demonstrativo de apoio às atividades contábeis na administração pública municipal. Sistema feito para auxilio do oficio de minha figura partena, sendo feito com o intuito de ajudar no seu trabalho de contador com o auxilio destas ferramentas.

## Como executar

1. Abra `html/login.html` no navegador (ou use a extensão Live Server apontando para esse arquivo).
2. Entre com os dados demonstrativos:
   - **E-mail:** `admin@papis.com`
   - **Senha:** `papis123`
3. Use o menu superior para navegar pelas páginas.

## Páginas

- `html/login.html`: tela de entrada demonstrativa com e-mail e senha.
- `html/Index.html`: painel inicial com atalhos e contadores de registros.
- `html/Apresentacao.html`: apresenta a motivação e os objetivos do Papis, preservando a imagem enviada no projeto.
- `html/Documentos.html`: cadastro e listagem de documentos.
- `html/Contratos.html`: cadastro e listagem de contratos (número, empresa, valor e vigência).
- `html/Folha_de_pagamento.html`: cadastro de funcionários e registro simplificado de folhas, com cálculo do líquido informado.
- `html/Tributos.html`: cadastro de tributos e simulação matemática de base × alíquota.
- `html/Pareceres.html`: cadastro e listagem de pareceres técnicos.

## Relação com o modelo conceitual enviado

O projeto considera as entidades e atributos representados no diagrama:

- **usuario:** `id_usuario`, `nome`, `email`, `senha` — a tela de login representa o acesso do usuário, mas a conta demonstrativa é fixa no JavaScript e não é persistida como cadastro real.
- **contrato:** número, empresa, valor, data inicial e data final.
- **documento:** nome, tipo, data de envio e descrição/arquivo (nesta versão, os metadados são registrados; upload persistente de arquivo não foi implementado).
- **parecer:** número, título, conteúdo e data de elaboração.
- **funcionario:** CPF, nome, cargo e salário-base.
- **folha_pagamento / item_folha:** competência, funcionário, salário bruto, descontos e salário líquido.
- **tributo / calculo_tributo:** nome, descrição, alíquota, base, data e valor calculado.

Os relacionamentos do diagrama são refletidos na navegação e no propósito das áreas, mas esta versão sem servidor não implementa chaves estrangeiras ou integridade referencial entre os registros. Por exemplo, o nome do funcionário é digitado ao registrar uma folha.

## Armazenamento e limitações importantes

- Os dados de formulários são armazenados em `localStorage` no navegador e no dispositivo em que foram cadastrados.
- Limpar os dados do navegador pode apagar os registros. Não há sincronização entre computadores ou usuários.
- O login é **apenas demonstrativo**: `admin@papis.com` / `papis123`. A validação ocorre no JavaScript do navegador e pode ser contornada. Não use dados pessoais, financeiros ou sigilosos.
- Não há back-end, banco de dados, criptografia de credenciais ou controle real de permissões.
- Os cálculos de folha e tributos são simulações aritméticas simples, não motores de cálculo tributário ou trabalhista. Não aplicam automaticamente legislação, faixas, deduções, encargos ou regras de vigência por hora. Os resultados devem ser conferidos e validados por profissional contábil antes de qualquer uso oficial.

## Tecnologias

HTML, CSS e JavaScript(esse foi usado i.a). Nenhum Java ou instalação de servidor é necessário para testar a demonstração local.

## Autor e inspiração

Projeto desenvolvido como iniciativa de aprendizado e aplicação prática de desenvolvimento web, inspirado no trabalho do pai do autor na área contábil da administração pública municipal.
