import React from 'react'
import PropTypes from 'prop-types'
import { logo, iconUser, iconMenu } from '../helpers/icons'

class TopNav extends React.Component {
    constructor(props) {
        super(props)
        this.state = { menuOpen: false }
        this.toggleNav = this.toggleNav.bind(this)
    }

    toggleNav() {
        this.setState({ menuOpen: !this.state.menuOpen })
    }

    render() {
        const { menuOpen } = this.state

        return (
            <div className="top-nav">
                <div className="top-nav__items">
                    <div className="avatar">
                        <img alt="Profile image" src={iconUser} />
                    </div>
                    <img className="logo" alt="Homebase logo" src={logo} />
                    <img
                        className="menu"
                        alt="Menu"
                        src={iconMenu}
                        onClick={() => this.toggleNav()}
                    />
                </div>
                {menuOpen && (
                    <div className="nav-pop-up">
                        <div className="nav-pop-up__item">Groups</div>
                        <div className="nav-pop-up__item">Logout</div>
                    </div>
                )}
            </div>
        )
    }
}

TopNav.propTypes = {}

export default TopNav
