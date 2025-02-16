;; Energy Token Contract

;; Define the fungible token
(define-fungible-token energy-token)

;; Define constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-insufficient-balance (err u101))

;; Mint new tokens (only contract owner)
(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (ft-mint? energy-token amount recipient)
  )
)

;; Transfer tokens
(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) err-owner-only)
    (ft-transfer? energy-token amount sender recipient)
  )
)

;; Get balance
(define-read-only (get-balance (account principal))
  (ft-get-balance energy-token account)
)

;; Get total supply
(define-read-only (get-total-supply)
  (ft-get-supply energy-token)
)

;; Burn tokens
(define-public (burn (amount uint) (sender principal))
  (begin
    (asserts! (is-eq tx-sender sender) err-owner-only)
    (ft-burn? energy-token amount sender)
  )
)

