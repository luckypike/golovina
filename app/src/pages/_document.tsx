import Document, { Html, Head, Main, NextScript, DocumentContext } from 'next/document'
import axios from 'axios'

class DocumentPage extends Document {
  render() {
    return (
      <Html lang="ru">
        <Head />
        <body>
          <Main />
          <NextScript />
        </body>
      </Html>
    )
  }
}

export default DocumentPage
