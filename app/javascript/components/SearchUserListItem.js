import React from "react"

const SearchUserListItem = ({ user }) => {
  return (
    <li className='list-item'>
      <a className='text-decoration-none list-item-link' href={user.user_url}>
        <img width="35" className="avatar-image" src={user.user_avatar_url} />
        <span className='list-item-span' dangerouslySetInnerHTML={{ __html: user.username }} />
      </a>
    </li>
  )
}

export default SearchUserListItem
