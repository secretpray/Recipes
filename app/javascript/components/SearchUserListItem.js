import React from "react"

class SearchUserListItem extends React.Component {
  render() {
    return (
      <li className='list-item'>
        <a className='text-decoration-none list-item-link' href={this.props.user.user_url}>
          <img width="35" className="avatar-image" src={this.props.user.user_avatar_url} />
          <span className='list-item-span' dangerouslySetInnerHTML={{ __html: this.props.user.username }} />
        </a>
      </li>
    );
  }
}
export default SearchUserListItem
