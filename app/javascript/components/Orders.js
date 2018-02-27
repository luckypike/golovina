import React from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import classNames from 'classnames';

import qs from 'querystring';

import {
  BrowserRouter as Router,
  Route,
  Link
} from 'react-router-dom';

class OrdersListItem extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      open: false
    }
  }

  toggleItem = () => {
    console.log('Toggle');

    this.setState(prevState => ({
      open: !prevState.open
    }));
  }

  payAction = (e) => {
    e.stopPropagation();
  }

  render () {
    const order = this.props.order;

    return (
      <div className="orders_list_item" onClick={this.toggleItem}>
        <div className="fr">
          <div className="fr_title">
            № {order.id}
          </div>

          <div className="fr_date">
            {order.date}
          </div>

          <div className="fr_amount" dangerouslySetInnerHTML={{ __html: order.amount_human }} />

          <div className={"fr_state " + order.state}>
            {order.state_human}
          </div>

          <div className="fr_actions">
            {order.can_pay &&
              <a onClick={this.payAction} href={order.pay_path} className="btn btn_sm">Оплатить</a>
            }
          </div>
        </div>

        <div className={classNames('sr', { sr_open: this.state.open })}>
          <div className="sr_data">
            <div className="name">Получатель: <span>{order.name}</span></div>
            <div className="phone">Телефон: <span>{order.phone}</span></div>
            <div className="address">Адрес: <span>{order.address}</span></div>
          </div>
          <div className="sr_products">
            {order.items.map((item) =>
              <div key={item.id} className="sr_products_item">
                <div className="sr_products_item_image">
                  {item.image &&
                    <img src={item.image} />
                  }
                </div>

                <div className="sr_products_item_data">
                  <p className="title">{item.title}</p>
                  <p>Цвет: <span>{item.color}</span></p>
                  <p>Размер: <span>{item.size}</span></p>
                  <p>Количество: <span>{item.quantity}</span></p>
                  <p>
                    Цена: <span dangerouslySetInnerHTML={{ __html: item.price }} />
                  </p>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    );
  }
}


class OrdersList extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      orders: null,
    }
  }

  componentDidMount() {
    this.fetchOrders();
  }

  fetchOrders() {
    axios.get(this.props.url)
    .then(res => {
      this.setState({
        orders: res.data.orders
      });
    });
  }

  render () {
    const orders = this.state.orders;

    if(!orders) return orders;

    return (
      <React.Fragment>
        <div className="orders_list">
          {orders.map((order) =>
            <OrdersListItem key={order.id} order={order} />
          )}
        </div>
      </React.Fragment>
    );
  }
}

class StateTab extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      active: false,
    }
  }

  render () {
    return (
      <Link to={this.props.to}>ЙЙЙ</Link>
    );
  }
}

class Orders extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      state: null,
    }
  }

  checkState = (match, location) => {
    let query = qs.parse(location.search.substring(1));
    console.log(this);

    // const eventID = parseInt(match.params.eventID)
    // return !isNaN(eventID) && eventID % 2 === 1
    return false;
  }

  render () {
    return (
      <Router>
        <Route path={this.props.path} render={props => (
          <React.Fragment>
            <div className="state_tabs">
              <StateTab to={{ pathname: this.props.path }} state={null} />
              <StateTab to={{ pathname: this.props.path, search: qs.stringify({ state: 'active' }) }} state={'active'} active_state={this.state.state} />
            </div>

            <OrdersList {...props} {...this.props} state={this.state.state} />
          </React.Fragment>
        )}/>
      </Router>
    );
  }
}

Orders.propTypes = {
  url: PropTypes.string,
  path: PropTypes.string
};

export default Orders;
