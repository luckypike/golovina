import React from 'react';
import PropTypes from 'prop-types';

import qs from 'query-string';

import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom';

class ControlProducts extends React.Component {
  constructor(props) {
    super(props);
  }

  render () {
    // const regions = this.props.regions;
    //
    // if(regions.length > 0) {
    //   $('.page_abiturs_vacancies_map').slideDown();
    // } else {
    //   return null;
    // }

    return (
      <div className="vacancies_regions_list">
        {'PRODUCTS'}
      </div>
    )
  };
}

class ControlIndex extends React.Component {
  render () {
    return (
      <Router>
        <React.Fragment>
          <Route exact path={decodeURIComponent(this.props.path)} render={props => (
            <ControlProducts {...props} {...this.props} />
          )}/>
        </React.Fragment>
      </Router>
    );
  }
}

export default ControlIndex;
