# Documento de Especificação de Requisitos de Software (SRS)

- **Aplicativo de Monitoramento Fitness (Flutter)**
- **Versão:** 1.0
- **Data:** 30/04/2026
- **Link Prototipagem:** https://www.figma.com/design/QDwCB20KHTEGgHCA7xhMCU/Dashboard-Responsivo---Flutter?node-id=0-1&t=2WSY3Y4A8zJ9cUn9-1


---

## 1. Introdução

### 1.1 Propósito

Este documento descreve os requisitos para o desenvolvimento de um aplicativo mobile responsivo voltado ao monitoramento de saúde e atividades físicas, utilizando Flutter e Provider para gerenciamento de estado.

### 1.2 Escopo

O sistema permitirá ao usuário:

* Registrar atividades físicas;
* Acompanhar progresso;
* Visualizar métricas de desempenho;
* Configurar preferências pessoais.

O aplicativo será um protótipo funcional com navegação fluida e interface responsiva.

### 1.3 Definições

* **Provider:** Gerenciador de estado para atualização reativa da interface.
* **Dashboard:** Tela com resumo de métricas do usuário.
* **Atividades Pendentes:** Exercícios ainda não realizados.
* **Atividades Concluídas:** Exercícios já realizados.

---

## 2. Visão Geral do Sistema

### 2.1 Perspectiva do Produto

Aplicativo independente (standalone), desenvolvido em Flutter, com arquitetura baseada em separação de responsabilidades (UI, lógica e estado).

### 2.2 Funções do Sistema

* Gerenciar atividades físicas;
* Atualizar listas em tempo real;
* Exibir métricas no dashboard;
* Controlar navegação entre telas;
* Permitir personalização via configurações.

### 2.3 Usuários

* Usuários comuns interessados em saúde e bem-estar.

### 2.4 Restrições

* Uso obrigatório de Flutter;
* Uso obrigatório do Provider;
* Interface responsiva;
* Aplicação local (sem backend).

---

## 3. Requisitos Funcionais

### RF01 – Tela Inicial

O sistema deve exibir:

* Nome do aplicativo;
* Slogan;
* Imagem ilustrativa;
* Botão “Começar”.

### RF02 – Navegação

O sistema deve possuir:

* AppBar com título;
* Drawer com menu lateral;
* BottomNavigationBar com:

  * Dashboard;
  * Atividades;
  * Configurações.

### RF03 – Atividades Pendentes

O sistema deve:

* Exibir lista de atividades (ListView);
* Permitir marcar atividade como concluída;
* Atualizar estado via Provider.

### RF04 – Atividades Concluídas

O sistema deve:

* Exibir atividades concluídas;
* Receber itens automaticamente ao concluir uma atividade.

### RF05 – Gerenciamento de Estado

O sistema deve:

* Atualizar listas em tempo real;
* Sincronizar interface com Provider.

### RF06 – Dashboard

O sistema deve exibir:

* Total de atividades concluídas;
* Total de atividades pendentes;
* Calorias estimadas;
* Tempo total;
* Meta semanal;
* Nível de atividade.

### RF07 – Configurações

O sistema deve permitir:

* Alterar nome do usuário;
* Definir meta semanal;
* Alternar tema (modo escuro);
* Resetar progresso.

### RF08 – Navegação por Abas

A tela de atividades deve conter:

* TabBarView com:

  * Pendentes;
  * Concluídas.

---

## 4. Requisitos Não Funcionais

### RNF01 – Usabilidade

Interface intuitiva e organizada.

### RNF02 – Desempenho

Atualização em tempo real sem atrasos perceptíveis.

### RNF03 – Manutenibilidade

Código modular, organizado e comentado.

### RNF04 – Responsividade

Layout adaptável para diferentes tamanhos de tela.

---

## 5. Arquitetura do Sistema

### 5.1 Estrutura

* **View (UI):** Widgets Flutter
* **Controller/Provider:** Gerenciamento de estado
* **Model:** Estrutura de dados das atividades

---

## 6. Modelo de Dados

### Atividade

* nome: String
* concluida: bool
* duracao: int
* calorias: double

---

## 7. Regras de Negócio

* Uma atividade concluída deve ser removida da lista de pendentes;
* Deve ser adicionada automaticamente à lista de concluídas;
* Dashboard deve atualizar automaticamente;
* Reset deve limpar todos os dados.

---

## 8. Critérios de Aceitação

* Navegação funcional entre telas;
* Atualização dinâmica com Provider;
* Listas funcionando corretamente;
* Dashboard refletindo dados reais;
* Configurações aplicáveis em tempo real.

---

## 9. Considerações Finais

O sistema deve seguir boas práticas:

* Separação de responsabilidades;
* Reutilização de componentes;
* Código limpo e organizado.
