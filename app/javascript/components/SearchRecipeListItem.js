import React from "react"

class SearchRecipeListItem extends React.Component {
  render() {
    return (
      <li className='list-item'>
        <a className='text-decoration-none list-item-link' href={this.props.recipe.recipe_url}>
          <img width="35" className="avatar-image" src={this.props.recipe.recipe_image_url} />
          <span className='list-item-span' dangerouslySetInnerHTML={{ __html: this.props.recipe.title }} />
        </a>
      </li>
    );
  }
}
export default SearchRecipeListItem
