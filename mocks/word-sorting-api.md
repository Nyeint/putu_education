# Word Sorting Game API

## GET /api/v1/games/word-sorting

Returns a randomized set of words for the client-driven Word Sorting Game. All
game presentation logic (hint text, letter scrambling/shuffling, answer
validation) is handled on-device — the API only supplies raw word + media
references.

### Query Parameters

| Name       | Type    | Required | Default | Description                                                        |
|------------|---------|----------|---------|----------------------------------------------------------------------|
| `limit`    | integer | No       | `10`    | Number of items to return. Max `50`.                                |
| `language` | string  | No       | `en`    | Locale for word/audio content. Supported: `en`, `mm`.                |

### Example Request

```
GET /api/v1/games/word-sorting?limit=10&language=en
```

### Response `200 OK`

```json
{
  "success": true,
  "game_type": "word_sorting",
  "category": "english",
  "total_questions": 10,
  "data": [
    {
      "id": "word_001",
      "word": "CAT",
      "image_url": "https://cdn.putueducation.com/images/cat.png",
      "audio_url": "https://cdn.putueducation.com/audio/en/cat.mp3"
    }
  ]
}
```

### `data[]` Item Schema

| Field       | Type   | Description                                              |
|-------------|--------|-----------------------------------------------------------|
| `id`        | string | Stable unique identifier for the word item.               |
| `word`      | string | The target word, always uppercase (e.g. `"CAT"`).         |
| `image_url` | string | CDN URL to the item's illustration (PNG).                  |
| `audio_url` | string | CDN URL to the MP3 pronunciation of `word`.                |

No other fields are returned — hint text and pre-scrambled letter arrays are
intentionally omitted; the client owns shuffling and prompt copy.

### Error Response `400 Bad Request`

```json
{
  "success": false,
  "error": {
    "code": "INVALID_LANGUAGE",
    "message": "Unsupported language code 'fr'. Supported: en, mm."
  }
}
```

### Mockoon / Postman

Import [`word-sorting-response.json`](./word-sorting-response.json) as the
static 200 response body for a route bound to
`GET /api/v1/games/word-sorting`.
