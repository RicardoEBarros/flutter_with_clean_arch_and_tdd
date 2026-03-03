# Advanced Flutter - Lista de Jogadores de Futebol

Este projeto foi desenvolvido durante o curso **"Flutter Avançado com Clean Architecture e TDD"**. A aplicação consiste em uma tela única que permite ao usuário visualizar a lista de jogadores de futebol escalados para a próxima partida, focando em práticas de desenvolvimento escaláveis e testáveis.

## 🚀 Tecnologias e Padrões Aplicados

Este projeto demonstra a aplicação de engenharia de software avançada no ecossistema Mobile:

* **Clean Architecture**: Separação rigorosa de camadas (Domain, Data, Presentation, Main) para garantir que as regras de negócio sejam independentes de frameworks e drivers externos.
* **TDD (Test Driven Development)**: Fluxo de desenvolvimento orientado a testes, garantindo alta cobertura e confiabilidade desde a primeira linha de código.
* **Programação Reativa**: Utilização de `RxDart` para um gerenciamento de estado baseado em Streams, tornando a interface altamente responsiva.
* **Princípios SOLID**: Código desacoplado e fácil de manter, utilizando Injeção de Dependência e o padrão Decorator.

## 🛠️ Stack Técnica

* **Linguagem:** Dart
* **Framework:** Flutter (SDK ^3.9.2)
* **Gerenciamento de Estado:** Streams / RxDart
* **Principais Dependências:**
    * `http`: Consumo de APIs REST.
    * `flutter_cache_manager`: Cache eficiente de dados e imagens.
    * `dartx`: Extensões para um código Dart mais expressivo.
* **Ferramentas de Teste:**
    * `faker`: Geração de dados randômicos para testes de unidade.
    * `network_image_mock`: Mock de requisições de imagem para testes de UI.
    ## 📦 Como Executar o Projeto

### 1. Pré-requisitos
* Flutter SDK instalado.
* Celular Android conectado via USB com a **Depuração USB** ativa.

### 2. Instalação
```bash
git clone [https://github.com/seu-usuario/advanced_flutter.git](https://github.com/seu-usuario/advanced_flutter.git)
cd advanced_flutter
flutter pub get
```

### 3. Executando os Testes
```bash
flutter test
```

### 4. Rodando no Celular (Instalação Direta via USB)
```bash
flutter run
```