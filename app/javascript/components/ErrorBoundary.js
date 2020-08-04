import { Component } from 'react'
import PropTypes from 'prop-types'
import { Notifier } from '@airbrake/browser'

class ErrorBoundary extends Component {
  constructor (props) {
    super(props)
    this.state = { hasError: false }
    this.airbrake = new Notifier({
      projectId: 285778,
      projectKey: 'c47f9106531ab66850f44c10e9965158'
    })
  }

  componentDidCatch (error, info) {
    this.setState({ hasError: true })

    this.airbrake.notify({
      error: error,
      params: { info: info }
    })
  }

  render () {
    // if (this.state.hasError) {
    //   return <h1>Something went wrong.</h1>
    // }

    return this.props.children
  }
}

ErrorBoundary.propTypes = {
  children: PropTypes.node
}

export default ErrorBoundary
