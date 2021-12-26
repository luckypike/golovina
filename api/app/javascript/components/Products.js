import React from "react"
import PropTypes from "prop-types"
class Products extends React.Component {
  render () {
    return (
      <React.Fragment>
        Url: {this.props.url}
        Path: {this.props.path}
      </React.Fragment>
    );
  }
}

Products.propTypes = {
  url: PropTypes.string,
  path: PropTypes.string
};
export default Products
