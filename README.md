# 🦉 Trustwise MCP Server

The **Trustwise MCP Server** is a [Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) server that provides a suite of advanced evaluation tools for AI safety, alignment, and performance. It enables developers and AI tools to programmatically assess the quality, safety, and cost of LLM outputs using Trustwise's industry-leading metrics.

## 💡 Use Cases

- Evaluating the safety and reliability of LLM responses.
- Measuring alignment, clarity, and helpfulness of AI-generated content.
- Estimating the carbon footprint and cost of model inference.
- Integrating robust evaluation into AI pipelines, agents, or orchestration frameworks.

## 🛠️ Prerequisites

- A Trustwise API Key ([get one here](https://trustwise.ai))
- Docker; Follow the [install instructions](https://docs.docker.com/desktop/) 

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

To point to a specific Trustwise Instance - under `env`, also set the following optional environment variable:
 ```
 TW_BASE_URL: "<YOUR_TRUSTWISE_INSTANCE_URL>"
```

e.g `"TW_BASE_URL": "https://api.yourdomain.ai"`

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
        "-e",
        "TW_BASE_URL",
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

### 🛡️ Trustwise Metrics

| Tool Name                | Description                                               |
|--------------------------|-----------------------------------------------------------|
| `faithfulness_metric`    | Evaluate the faithfulness of a response to its context    |
| `answer_relevancy_metric`| Evaluate relevancy of a response to the query             |
| `context_relevancy_metric`| Evaluate relevancy of context to the query               |
| `pii_metric`             | Detect PII in a response                                 |
| `prompt_injection_metric`| Detect prompt injection risk                             |
| `summarization_metric`   | Evaluate summarization quality                           |
| `clarity_metric`         | Evaluate clarity of a response                           |
| `formality_metric`       | Evaluate formality of a response                         |
| `helpfulness_metric`     | Evaluate helpfulness of a response                       |
| `sensitivity_metric`     | Evaluate sensitivity of a response                       |
| `simplicity_metric`      | Evaluate simplicity of a response                        |
| `tone_metric`            | Evaluate tone of a response                              |
| `toxicity_metric`        | Evaluate toxicity of a response                          |
| `refusal_metric`        | Detect refusal to answer or comply with the query         |
| `completion_metric`     | Evaluate completion of the query’s instruction            |
| `adherence_metric`      | Evaluate adherence to a given policy or instruction       |
| `stability_metric`      | Evaluate stability (consistency) of multiple responses    |
| `carbon_metric`          | Estimate carbon footprint of a response                   |
| `cost_metric`            | Estimate cost of a response                              |

> For more examples and advanced usage, see the official [Trustwise SDK](https://pypi.org/project/trustwise/).

## 📄 License

This project is licensed under the terms of the MIT open source license. See [LICENSE](./LICENSE.md) for details.

## 🔒 Security

- **Do not commit secrets or API keys.**
- This repository is public; review all code and documentation for sensitive information before pushing.

---