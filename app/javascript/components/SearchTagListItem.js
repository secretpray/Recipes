import React from "react"

class SearchTagListItem extends React.Component {
  render () {
    return (
      <li className='list-item'>
        <a className='text-decoration-none list-item-link' href={this.props.tag.tag_url}>
          <i className="fa fa-tag fa-lg p-2 me-2" />
          <span className='list-item-span badge bg-secondary' id='tag-item' dangerouslySetInnerHTML={{ __html: this.props.tag.name }} />
        </a>
      </li>
    );
  }
}

export default SearchTagListItem