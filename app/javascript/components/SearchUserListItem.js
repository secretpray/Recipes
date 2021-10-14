import React from "react"

const SearchUserListItem = (props) => {
  return (
    <li className='list-item'>
      <a className='text-decoration-none list-item-link' href={props.user.user_url}>
        <img width="35" className="avatar-image" src={props.user.user_avatar_url} />
        <span className='list-item-span' dangerouslySetInnerHTML={{ __html: props.user.username }} />
      </a>
    </li>
  )
}

export default SearchUserListItem
