# 🦉 Trustwise MCP Server

The **Trustwise MCP Server** is a [Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) server that provides a suite of advanced evaluation tools for AI safety, alignment, and performance. It enables developers and AI tools to programmatically assess the quality, safety, and cost of LLM outputs using Trustwise's industry-leading metrics.

## 💡 Use Cases

- Evaluating the safety and reliability of LLM responses.
- Measuring alignment, clarity, and helpfulness of AI-generated content.
- Estimating the carbon footprint and cost of model inference.
- Integrating robust evaluation into AI pipelines, agents, or orchestration frameworks.

## 🛠️ Prerequisites

- A Trustwise API Key ([get one here](https://trustwise.ai))
- Docker; Follow the [install instructions](https://docs.docker.com/engine/install/) 

## 📦 Installation & Running

### Claude Desktop

To connect the Trustwise MCP Server to Claude Desktop, add the following configuration to your Claude Desktop settings:

```json
{
  "mcpServers": {
    "trustwise": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "TW_API_KEY",
        "ghcr.io/trustwiseai/trustwise-mcp-server:latest"
      ],
      "env": {
        "TW_API_KEY": "<YOUR_TRUSTWISE_API_KEY>"
      }
    }
  }
}
```

### Cursor

To connect the Trustwise MCP Server to cursor, add the following configuration to your cursor settings:

```json
{
  "mcpServers": {
    "trustwise": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "TW_API_KEY",
        "ghcr.io/trustwiseai/trustwise-mcp-server:latest"
      ],
      "env": {
        "TW_API_KEY": "<YOUR_TRUSTWISE_API_KEY>"
      }
    }
  }
}
```

Replace `<YOUR_TRUSTWISE_API_KEY>` with your actual Trustwise API key.

## 🧰 Tools

The Trustwise MCP Server exposes the following tools (metrics). Each tool can be called with the specified arguments to evaluate a model response.

### 🛡️ Safety Metrics

| Tool Name                | Description                                               |
|--------------------------|-----------------------------------------------------------|
| `faithfulness_metric`    | Evaluate the faithfulness of a response to its context    |
| `answer_relevancy_metric`| Evaluate relevancy of a response to the query             |
| `context_relevancy_metric`| Evaluate relevancy of context to the query               |
| `pii_metric`             | Detect PII in a response                                 |
| `prompt_injection_metric`| Detect prompt injection risk                             |
| `summarization_metric`   | Evaluate summarization quality                           |

### 🎯 Alignment Metrics

| Tool Name                | Description                                               |
|--------------------------|-----------------------------------------------------------|
| `clarity_metric`         | Evaluate clarity of a response                           |
| `formality_metric`       | Evaluate formality of a response                         |
| `helpfulness_metric`     | Evaluate helpfulness of a response                       |
| `sensitivity_metric`     | Evaluate sensitivity of a response                       |
| `simplicity_metric`      | Evaluate simplicity of a response                        |
| `tone_metric`            | Evaluate tone of a response                              |
| `toxicity_metric`        | Evaluate toxicity of a response                          |

### ⚡ Performance Metrics

| Tool Name                | Description                                               |
|--------------------------|-----------------------------------------------------------|
| `carbon_metric`          | Estimate carbon footprint of a response                   |
| `cost_metric`            | Estimate cost of a response                              |

> For more examples and advanced usage, see the official [Trustwise SDK](https://pypi.org/project/trustwise/).

## 📄 License

This project is licensed under the terms of the MIT open source license. See [LICENSE](./LICENSE.md) for details.

## 🔒 Security

- **Do not commit secrets or API keys.**
- This repository is public; review all code and documentation for sensitive information before pushing.

---