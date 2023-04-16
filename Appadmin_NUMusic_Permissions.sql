-- Customer Service Permissions
-- Table grants
GRANT SELECT ON USER_DETAILS TO AppCustomerService;
GRANT SELECT ON SUBSCRIPTION TO AppCustomerService;
GRANT SELECT ON DOWNLOAD TO AppCustomerService;
GRANT SELECT ON ARTIST TO AppCustomerService;
GRANT SELECT ON ALBUM_ARTIST TO AppCustomerService;
GRANT SELECT ON ALBUM TO AppCustomerService;
GRANT SELECT ON SONGS_ARTIST TO AppCustomerService;
GRANT SELECT ON SONGS TO AppCustomerService;
GRANT SELECT ON LYRICS TO AppCustomerService;
GRANT SELECT ON SONGS_PLAYLIST TO AppCustomerService;
GRANT SELECT ON PLAYLIST TO AppCustomerService;
GRANT SELECT ON FAVOURITES TO AppCustomerService;


--Package Grants
GRANT EXECUTE ON PKG_USER_MGMT TO AppCustomerService;
GRANT EXECUTE ON PKG_SUBSCRIPTION_MGMT TO AppCustomerService;
GRANT EXECUTE ON update_auto_renewal TO AppCustomerService;


-- App Paid User Grants

GRANT EXECUTE ON PKG_SUBSCRIPTION_MGMT TO AppPaidUser;
GRANT EXECUTE ON PKG_USER_MGMT TO AppPaidUser;
GRANT EXECUTE ON download_songs TO AppPaidUser;
GRANT EXECUTE ON update_auto_renewal TO AppPaidUser;

-- App UnPaid User Grants

GRANT EXECUTE ON PKG_SUBSCRIPTION_MGMT TO AppUnPaidUser;
GRANT EXECUTE ON PKG_USER_MGMT TO AppUnPaidUser;
