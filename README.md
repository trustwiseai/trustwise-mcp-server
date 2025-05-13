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

| Tool Name                | Description                                               | Arguments                                                                                  |
|--------------------------|-----------------------------------------------------------|--------------------------------------------------------------------------------------------|
| `faithfulness_metric`    | Evaluate the faithfulness of a response to its context    | `query: str`, `response: str`, `context: list[dict]`                                       |
| `answer_relevancy_metric`| Evaluate relevancy of a response to the query             | `query: str`, `response: str`, `context: list[dict]`                                       |
| `context_relevancy_metric`| Evaluate relevancy of context to the query               | `query: str`, `context: list[dict]`, `response: str`                                       |
| `pii_metric`             | Detect PII in a response                                 | `text: str`, `allowlist: list[str]`, `blocklist: list[str]`                                |
| `prompt_injection_metric`| Detect prompt injection risk                             | `query: str`, `response: str`, `context: list[dict]`                                       |
| `summarization_metric`   | Evaluate summarization quality                           | `query: str`, `response: str`, `context: list[dict]`                                       |

### 🎯 Alignment Metrics

| Tool Name                | Description                                               | Arguments                                                                                  |
|--------------------------|-----------------------------------------------------------|--------------------------------------------------------------------------------------------|
| `clarity_metric`         | Evaluate clarity of a response                           | `query: str`, `response: str`                                                              |
| `formality_metric`       | Evaluate formality of a response                         | `response: str`                                                                            |
| `helpfulness_metric`     | Evaluate helpfulness of a response                       | `query: str`, `response: str`                                                              |
| `sensitivity_metric`     | Evaluate sensitivity of a response                       | `response: str`, `topics: list[str] (optional)`, `query: str (optional)`                   |
| `simplicity_metric`      | Evaluate simplicity of a response                        | `response: str`                                                                            |
| `tone_metric`            | Evaluate tone of a response                              | `response: str`                                                                            |
| `toxicity_metric`        | Evaluate toxicity of a response                          | `response: str`                                                                            |

### ⚡ Performance Metrics

| Tool Name                | Description                                               | Arguments                                                                                  |
|--------------------------|-----------------------------------------------------------|--------------------------------------------------------------------------------------------|
| `carbon_metric`          | Estimate carbon footprint of a response                   | `processor_name: str`, `provider_name: str`, `provider_region: str`, `instance_type: str`, `average_latency: int` |
| `cost_metric`            | Estimate cost of a response                              | `model_name: str`, `model_type: str`, `model_provider: str`, `number_of_queries: int`, `total_prompt_tokens: int`, `total_completion_tokens: int`, `total_tokens: int (optional)`, `instance_type: str (optional)`, `average_latency: float (optional)` |

> For more examples and advanced usage, see the official [Trustwise SDK](https://pypi.org/project/trustwise/).

## 📄 License

This project is licensed under the terms of the MIT open source license. See [LICENSE](./LICENSE) for details.

## 🔒 Security

- **Do not commit secrets or API keys.**
- This repository is public; review all code and documentation for sensitive information before pushing.

---