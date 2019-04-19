import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'
import ReactMarkdown from 'react-markdown'
import Glide from '@glidejs/glide'

import { path } from '../Routes'


import page from '../Page'
import styles from './Show.module.css'

class Show extends Component {
  state = {
    post: null,
    index: 1
  }

  componentDidMount = async () => {
    const res = await axios.get(path('post_path', { id: this.props.id, format: 'json' }))
    this.setState({ post: res.data.post })

    window.addEventListener('resize', this.updateDimensions)
  }

  componentDidUpdate(prevProps, prevState) {
    if(!prevState.post) {
      if(this.glide) {
        this.glide.destroy()
        this.glide = null
      }
      this.updateDimensions()
    }
  }

  mount = React.createRef()
  slides = React.createRef()

  render () {
    const { post, index } = this.state

    if (!post) return null

    return (
      <div className={styles.root}>
        <div className={styles.title}>
          <h1>
            {post.title}
          </h1>
        </div>

        <div className={styles.video}>
          <div className={styles.player}>
            <iframe src={`https://www.youtube.com/embed/MphgaDHqFL4?modestbranding=1&autohide=1&showinfo=0&rel=0&cc_load_policy=1`} frameBorder="0" allow="autoplay; encrypted-media" allowFullScreen />
          </div>
        </div>

        <div className={styles.text}>
          <ReactMarkdown source={post.text} />
        </div>

        <div className={classNames('glide', styles.images)} ref={this.mount}>
            {post.images.length > 1 &&
              <div className={styles.counter}>{index}/{post.images.length}</div>
            }
            <div className="glide__track" data-glide-el="track">
              <div ref={this.slides} className={classNames('glide__slides', styles.slides)}>
                {post.images.map((image, i) =>
                  <div className={classNames('glide__slide', styles.slide)} key={i}>
                    <img src={image.large} />
                  </div>
                )}
              </div>
            </div>
          </div>
      </div>
    )
  }

  updateDimensions = () =>  {
    if(!this.glide) {
      this.glide = new Glide(this.mount.current, {
        rewind: false,
        gap: 0
      })
      this.glide.on('run', (move) => {
        this.setState({ index: this.glide.index + 1 })
      })
      this.glide.mount()
    }
  }
}

export default Show
