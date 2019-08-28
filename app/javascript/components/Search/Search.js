import React, { Component } from 'react'
import { BrowserRouter as Router, Route } from 'react-router-dom'

import Index from './Index'
import { Routes } from '../Routes'

class Search extends Component {
  render () {
    return (
      <Router>
        <Route path={Routes.search_path} render={props => <Index {...props} {...this.props} />} />
      </Router>
    )
  }
}

export default Search
