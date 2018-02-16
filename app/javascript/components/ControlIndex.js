import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import classNames from 'classnames';

import qs from 'query-string';

import {
  BrowserRouter as Router,
  Route,
  NavLink
} from 'react-router-dom';

class ControlVariants extends React.Component {
  constructor(props) {
    super(props);
  }

  render () {
    const variants = this.props.variants;
    console.log(variants);

    return (
      <div className="variants">
        {variants.map((variant) =>
          <div className="variants_item" key={variant.id}>
            <div className="image">
              {variant.image &&
                <img src={variant.image} />
              }
            </div>
            <div className="title">
              {variant.title} - {variant.color}
            </div>
          </div>
        )}
      </div>
    )
  };
}

class ControlCategories extends React.Component {
  constructor(props) {
    super(props);

    this.state ={
      categories: null
    }
  }

  componentDidMount() {
    this.fetchCategories();
  }

  fetchCategories() {
    axios.get(this.props.categories_path)
    .then(res => {
      this.setState({
        categories: res.data.categories
      });
    });
  }

  render () {
    const categories = this.state.categories;

    if(!categories) return null;

    return (
      <div className="control_categories">
        {categories.filter(category => category.parent_category_id == null).map((category) =>
          <ControlCategoriesListItem variants_path={this.props.variants_path} categories_all={categories} category={category}  key={category.id} />
        )}
      </div>
    )
  };
}


class ControlCategoriesListItem extends React.Component {
  constructor(props) {
    super(props);

    this.state ={
      categories: null,
      variants: null,
      active: false
    }
  }

  componentDidMount() {

  }

  componentDidUpdate(prevProps, prevState) {
    console.log(this.state);
    if(this.state.active && !prevState.active) {
      console.log('QQQQ');
      this.fetchVariants();
    }
  }

  fetchVariants() {
    console.log(this.props);
    axios.get(this.props.variants_path, { params: { category_id: this.props.category.id } })
    .then(res => {
      this.setState({
        variants: res.data.variants
      });
    });
  }

  handleClick = () => {
    this.setState(prevState => ({
      active: !prevState.active
    }));
  }

  render () {
    const categories = this.props.categories_all.filter(category => category.parent_category_id == this.props.category.id);
    const variants = this.state.variants;

    return (
      <div className="control_categories_item">
        <div className="title" onClick={this.handleClick}>
          {this.props.category.title} ({this.props.category.variants_count})
        </div>

        {categories.length > 0 &&
          <div className={classNames('categories', { opened: this.state.active })}>
            {categories.map((category) =>
              <ControlCategoriesListItem variants_path={this.props.variants_path} categories_all={this.props.categories_all} category={category} key={category.id} />
            )}
          </div>
        }

        {this.state.active && variants &&
          <ControlVariants variants={variants} />
        }
      </div>
    )
  };
}

class ControlIndex extends React.Component {
  render () {
    return (
      <Router>
        <React.Fragment>
          <div className="tabs">
            <NavLink exact to={this.props.path} className="tabs_item">
              Активные
            </NavLink>

            <NavLink exact to={this.props.path + '/archive'} className="tabs_item">
              Архив
            </NavLink>
          </div>
          <Route path={this.props.path} render={props => (
            <ControlCategories {...props} {...this.props} />
          )}/>
        </React.Fragment>
      </Router>
    );
  }
}

export default ControlIndex;
