import React from 'react';
import axios from 'axios';
import classNames from 'classnames';

import { path } from '../Routes';

import styles from './Image.module.css';

class Image extends React.Component {
  state = {
    name: this.props.file.name,
    error: false,
    save: false,
    upload: 0,
    send: false,
  }

  componentDidMount() {
    console.log('mount');
    if(!this.state.save) this._saveFile();
  }

  _saveFile() {
    const { file } = this.props;

    const formData = new FormData();
    formData.append("image[photo]", file);
    formData.append("authenticity_token", document.querySelector('[name="csrf-token"]').content);


    axios.post(
      path('images_path'),
      formData,
      {
        onUploadProgress: progressEvent => {
          const upload = Math.floor((progressEvent.loaded * 100) / progressEvent.total);
          this.setState({ upload });
        }
      })
      .then(response => {
        this.setState({ send: true });
        console.log(response.data.image);
        if(this.props.onFileUpload) this.props.onFileUpload(response.data.photo);
      }).catch((error) => {
        this.setState({ error: true });
      }).then(() => {
        this._asyncRequest = null;
      });
  }

  shouldComponentUpdate(nextProps, nextState) {
    return (this.state != nextState);
  }

  static getDerivedStateFromProps(props, state) {
    return null;
  }

  componentDidUpdate() {
    // console.log(this.props.file);
  }

  render() {
    const { upload, name, error, send } = this.state;

    return (
      <div className={classNames(styles.root, { [styles.error]: error, [styles.upload]: upload >= 100 && !send, [styles.send]: send })}>
        {upload >= 100 && !send &&
          <div className={styles.ring}>
            <div />
          </div>
        }
        <div className={styles.bar} style={{ width: `${upload}%`  }} />
        {name}
      </div>
    );
  }
}

export default Image;
