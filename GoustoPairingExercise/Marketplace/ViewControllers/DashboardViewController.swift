import UIKit

/// Displays a welcome dashboard containing a countdown to the next menu release.
class DashboardViewController: UIViewController {

    // MARK: Properties

    private let viewModel: DashboardViewModel
    private let dashboardView = DashboardView()


    // MARK: Initialisation
    
    init(viewModel: DashboardViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = dashboardView
    }

    @available(*, deprecated)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        dashboardView.marketplaceButton.addAction(UIAction(handler: { [weak self] _ in
            self?.diplayProducts()
        }), for: .touchUpInside)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.startCountdown()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.stopCountdown()
    }
    
    func bindViewModel() {
        viewModel.onCountdownUpdate = { [weak self] text in
            self?.dashboardView.countdownLabel.text = text
        }
    }
}

// MARK: - Private methods

private extension DashboardViewController {
    
    func diplayProducts() {
        let viewController = MarketplaceViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
