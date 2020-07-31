import React from 'react'
import PropTypes from 'prop-types'
import { iconFlag, iconSmile, iconCalendar, iconPlus } from '../helpers/icons'

const BottomNav = () => (
    <div className="bottom-nav">
        <span className="bottom-nav__icon">
            <img src={iconFlag} alt="Home" />
            Home
        </span>
        <span className="bottom-nav__icon">
            <img src={iconSmile} alt="My Stuff" />
            My Stuff
        </span>
        <span className="bottom-nav__icon">
            <img src={iconCalendar} alt="Calendar" />
            Calendar
        </span>
        <span className="bottom-nav__icon">
            <img src={iconPlus} alt="New" />
            New
        </span>
    </div>
)

BottomNav.propTypes = {}

export default BottomNav
