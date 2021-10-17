import React from "react"

const SearchRecipeListItem = ({ recipe }) => {
  return (
    <li className='list-item'>
      <a className='text-decoration-none list-item-link' href={recipe.recipe_url}>
        <img width="35" className="avatar-image" src={recipe.recipe_image_url} />
        <span className='list-item-span' dangerouslySetInnerHTML={{ __html: recipe.title }} />
      </a>
    </li>
  );
}

export default SearchRecipeListItem
