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
    this.setState(prevState => ({
      open: !prevState.open
    }));
  }

  payAction = (e) => {
    if (!this.props.order.purchasable) {
      this.toggleItem();
      e.preventDefault();
    }
    e.stopPropagation();
  }

  archiveAction = (url, e) => {
    e.preventDefault();
    e.stopPropagation();
    axios.post(url, { authenticity_token: this.props.authenticity_token })
    .then(res => {
      if(res.status == 200) {
        this.props.fetchOrders();
      }
    });
  }

  render () {
    const order = this.props.order;

    let can_pay_classes = "btn btn_sm";
    if (!order.purchasable) can_pay_classes = "btn btn_sm btn_inac"
    
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
              <a onClick={this.payAction} href={order.pay_path} className={can_pay_classes}>Оплатить</a>
            }
            {order.archive_path &&
              <a onClick={(e) => this.archiveAction(order.archive_path, e)} href='#' className="btn btn_sm">Завершить</a>
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
              <OrderItem item={item} key={item.id}/>
            )}
          </div>
        </div>
      </div>
    );
  }
}

class OrderItem extends React.Component {
  render() {
    let avail_quantity = '';
    if (this.props.item.quantity > this.props.item.avail_quantity) {
      avail_quantity = <div className="error">Доступно для заказа: {this.props.item.avail_quantity}</div>;
    } else {
      avail_quantity = '';
    }

    return (
      <div className="sr_products_item">
        <div className="sr_products_item_image">
          {this.props.item.image &&
            <img src={this.props.item.image} />
          }
        </div>

        <div className="sr_products_item_data">
          <p className="title">{this.props.item.title}</p>
          <p>Цвет: <span>{this.props.item.color}</span></p>
          <p>Размер: <span>{this.props.item.size}</span></p>
          <p>Количество: <span>{this.props.item.quantity}</span></p>
          {avail_quantity}
          <p>
            Цена: <span dangerouslySetInnerHTML={{ __html: this.props.item.price }} />
          </p>
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
      state: null
    }

    this.fetchOrders = this.fetchOrders.bind(this);
  }

  componentDidMount() {
    this.setActiveState(this.props);
  }

  componentWillReceiveProps(nextProps) {
    this.setActiveState(nextProps);
  }

  setActiveState(props) {
    let query = qs.parse(props.location.search.substring(1));

    if(query.state == undefined || query.state == '') {
      query.state = null;
    }

    this.setState({
      state: query.state
    }, function() {
      this.fetchOrders();
    });
  }

  fetchOrders() {
    axios.get(this.props.url, { params: { state: this.state.state } })
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
        <div className="state_tabs">
          <StateTab pathname={this.props.path} active={null} state={this.state.state} label={'Все'}  />
          <StateTab pathname={this.props.path} active={'active'} state={this.state.state} label={'Новые'} />
          <StateTab pathname={this.props.path} active={'paid'} state={this.state.state} label={'Оплачены'} />
          <StateTab pathname={this.props.path} active={'archived'} state={this.state.state} label={'Архив'} />
          <StateTab pathname={this.props.path} active={'declined'} state={this.state.state} label={'Отменены'} />
        </div>

        <div className="orders_list">
          {orders.map((order) =>
            <OrdersListItem key={order.id} order={order} fetchOrders={this.fetchOrders} authenticity_token={this.props.authenticity_token} />
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

  componentDidMount() {
    this.setActiveState(this.props);
  }

  componentWillReceiveProps(nextProps) {
    this.setActiveState(nextProps);
  }

  setActiveState(props) {
    this.setState({
      active: props.state == props.active
    })
  }

  render () {
    return (
      <Link to={{ pathname: this.props.pathname, search: qs.stringify({ state: this.props.active }) }} className={classNames('state_tabs_item', { 'active': this.state.active })}>
        {this.props.label}
      </Link>
    );
  }
}

class Orders extends React.Component {
  render () {
    return (
      <Router>
        <Route path={this.props.path} render={props => (
          <OrdersList {...props} {...this.props} />
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
