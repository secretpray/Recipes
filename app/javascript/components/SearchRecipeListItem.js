import React from "react"

const SearchRecipeListItem = (props) => {
  return (
    <li className='list-item'>
      <a className='text-decoration-none list-item-link' href={props.recipe.recipe_url}>
        <img width="35" className="avatar-image" src={props.recipe.recipe_image_url} />
        <span className='list-item-span' dangerouslySetInnerHTML={{ __html: props.recipe.title }} />
      </a>
    </li>
  );
}

export default SearchRecipeListItem
