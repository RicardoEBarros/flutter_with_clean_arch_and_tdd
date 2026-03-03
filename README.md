# Advanced Flutter - Football Players List

Este projeto foi desenvolvido durante o curso **"Flutter Avançado com Clean Architecture e TDD"**. A aplicação consiste em uma tela única que lista os jogadores de futebol escalados para a próxima partida, focando em práticas de desenvolvimento escaláveis e testáveis.

## 🚀 Tecnologias e Padrões Aplicados

Este projeto não é apenas uma lista de jogadores, mas uma demonstração de engenharia de software aplicada ao mobile:

* **Clean Architecture**: Separação rigorosa de camadas (Domain, Data, Presentation, Main) para facilitar a manutenção e evolução do código.
* **TDD (Test Driven Development)**: Desenvolvimento orientado a testes, garantindo que cada funcionalidade seja validada antes mesmo de sua implementação final.
* **Programação Reativa**: Uso de `RxDart` para gerenciar o estado da aplicação de forma fluida.
* **Design Patterns**: Implementação de padrões como *Dependency Injection*, *Decorator* e *Adapter*.

## 🛠️ Stack Técnica

* **Linguagem:** Dart
* **Framework:** Flutter (SDK ^3.9.2)
* **Gerenciamento de Estado:** Streams / RxDart
* **Principais Dependências:**
    * `http`: Comunicação com APIs externas.
    * `flutter_cache_manager`: Gerenciamento de cache para performance.
    * `dartx`: Extensões utilitárias para código mais limpo.
* **Ferramentas de Teste:**
    * `faker`: Geração de dados aleatórios para testes robustos.
    * `network_image_mock`: Mock de imagens para testes de interface.

## 📦 Como Executar o Projeto

### 1. Pré-requisitos
Certifique-se de ter o Flutter instalado e o seu celular Android conectado via USB com a **Depuração USB** ativa.

### 2. Instalação
Clone o repositório e instale as dependências:
```bash
git clone [https://github.com/seu-usuario/advanced_flutter.git](https://github.com/seu-usuario/advanced_flutter.git)
cd advanced_flutter
flutter pub get